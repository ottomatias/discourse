require 'sidekiq'

module Sidekiq
  class Stats
    def processed
      Sidekiq.redis { |conn| conn.get("stat:processed") }.to_i
    end

    def failed
      Sidekiq.redis { |conn| conn.get("stat:failed") }.to_i
    end

    def reset
      Sidekiq.redis do |conn|
        conn.set("stat:failed", 0)
        conn.set("stat:processed", 0)
      end
    end

    def queues
      Sidekiq.redis do |conn|
        queues = conn.smembers('queues')

        array_of_arrays = queues.inject({}) do |memo, queue|
          memo[queue] = conn.llen("queue:#{queue}")
          memo
        end.sort_by { |_, size| size }

        Hash[array_of_arrays.reverse]
      end
    end

    def enqueued
      queues.values.inject(&:+) || 0
    end

    def scheduled_size
      Sidekiq.redis {|c| c.zcard('schedule') }
    end

    def retry_size
      Sidekiq.redis {|c| c.zcard('retry') }
    end

    class History
      def initialize(days_previous, start_date = nil)
        @days_previous = days_previous
        @start_date = start_date || Time.now.utc.to_date
      end

      def processed
        date_stat_hash("processed")
      end

      def failed
        date_stat_hash("failed")
      end

      private

      def date_stat_hash(stat)
        i = 0
        stat_hash = {}

        Sidekiq.redis do |conn|
          while i < @days_previous
            date = @start_date - i
            value = conn.get("stat:#{stat}:#{date}")

            stat_hash[date.to_s] = value ? value.to_i : 0

            i += 1
          end
        end

        stat_hash
      end
    end
  end

  ##
  # Encapsulates a queue within Sidekiq.
  # Allows enumeration of all jobs within the queue
  # and deletion of jobs.
  #
  #   queue = Sidekiq::Queue.new("mailer")
  #   queue.each do |job|
  #     job.klass # => 'MyWorker'
  #     job.args # => [1, 2, 3]
  #     job.delete if job.jid == 'abcdef1234567890'
  #   end
  #
  class Queue
    include Enumerable

    def self.all
      Sidekiq.redis {|c| c.smembers('queues') }.map {|q| Sidekiq::Queue.new(q) }
    end

    attr_reader :name

    def initialize(name="default")
      @name = name
      @rname = "queue:#{name}"
    end

    def size
      Sidekiq.redis { |con| con.llen(@rname) }
    end

    def latency
      entry = Sidekiq.redis do |conn|
        conn.lrange(@rname, -1, -1)
      end.first
      return 0 unless entry
      Time.now.to_f - Sidekiq.load_json(entry)['enqueued_at']
    end

    def each(&block)
      page = 0
      page_size = 50

      loop do
        entries = Sidekiq.redis do |conn|
          conn.lrange @rname, page * page_size, (page * page_size) + page_size - 1
        end
        break if entries.empty?
        page += 1
        entries.each do |entry|
          block.call Job.new(entry, @name)
        end
      end
    end

    def find_job(jid)
      self.detect { |j| j.jid == jid }
    end

    def clear
      Sidekiq.redis do |conn|
        conn.multi do
          conn.del(@rname)
          conn.srem("queues", name)
        end
      end
    end
  end

  ##
  # Encapsulates a pending job within a Sidekiq queue or
  # sorted set.
  #
  # The job should be considered immutable but may be
  # removed from the queue via Job#delete.
  #
  class Job
    attr_reader :item

    def initialize(item, queue_name=nil)
      @value = item
      @item = Sidekiq.load_json(item)
      @queue = queue_name || @item['queue']
    end

    def klass
      @item['class']
    end

    def args
      @item['args']
    end

    def jid
      @item['jid']
    end

    def enqueued_at
      Time.at(@item['enqueued_at'] || 0)
    end

    def queue
      @queue
    end

    def latency
      Time.now.to_f - @item['enqueued_at']
    end

    ##
    # Remove this job from the queue.
    def delete
      count = Sidekiq.redis do |conn|
        conn.lrem("queue:#{@queue}", 0, @value)
      end
      count != 0
    end

    def [](name)
      @item.send(:[], name)
    end
  end

  class SortedEntry < Job
    attr_reader :score

    def initialize(parent, score, item)
      super(item)
      @score = score
      @parent = parent
    end

    def at
      Time.at(score)
    end

    def delete
      @parent.delete(score, jid)
    end

    def reschedule(at)
      @parent.delete(score, jid)
      @parent.schedule(at, item)
    end

    def add_to_queue
      Sidekiq.redis do |conn|
        results = conn.zrangebyscore('schedule', score, score)
        conn.zremrangebyscore('schedule', score, score)
        results.map do |message|
          msg = Sidekiq.load_json(message)
          Sidekiq::Client.push(msg)
        end
      end
    end

    def retry
      raise "Retry not available on jobs not in the Retry queue." unless item["failed_at"]
      Sidekiq.redis do |conn|
        results = conn.zrangebyscore('retry', score, score)
        conn.zremrangebyscore('retry', score, score)
        results.map do |message|
          msg = Sidekiq.load_json(message)
          msg['retry_count'] = msg['retry_count'] - 1
          Sidekiq::Client.push(msg)
        end
      end
    end
  end

  class SortedSet
    include Enumerable

    def initialize(name)
      @zset = name
    end

    def size
      Sidekiq.redis {|c| c.zcard(@zset) }
    end

    def schedule(timestamp, message)
      Sidekiq.redis do |conn|
        conn.zadd(@zset, timestamp.to_s, Sidekiq.dump_json(message))
      end
    end

    def each(&block)
      # page thru the sorted set backwards so deleting entries doesn't screw up indexing
      page = -1
      page_size = 50

      loop do
        elements = Sidekiq.redis do |conn|
          conn.zrange @zset, page * page_size, (page * page_size) + (page_size - 1), :with_scores => true
        end
        break if elements.empty?
        page -= 1
        elements.each do |element, score|
          block.call SortedEntry.new(self, score, element)
        end
      end
    end

    def fetch(score, jid = nil)
      elements = Sidekiq.redis do |conn|
        conn.zrangebyscore(@zset, score, score)
      end

      elements.inject([]) do |result, element|
        entry = SortedEntry.new(self, score, element)
        if jid
          result << entry if entry.jid == jid
        else
          result << entry
        end
        result
      end
    end

    def find_job(jid)
      self.detect { |j| j.jid == jid }
    end

    def delete(score, jid = nil)
      if jid
        elements = Sidekiq.redis do |conn|
          conn.zrangebyscore(@zset, score, score)
        end

        elements_with_jid = elements.map do |element|
          message = Sidekiq.load_json(element)

          if message["jid"] == jid
            Sidekiq.redis { |conn| conn.zrem(@zset, element) }
          end
        end
        elements_with_jid.count != 0
      else
        count = Sidekiq.redis do |conn|
          conn.zremrangebyscore(@zset, score, score)
        end
        count != 0
      end
    end

    def clear
      Sidekiq.redis do |conn|
        conn.del(@zset)
      end
    end
  end

  ##
  # Allows enumeration of scheduled jobs within Sidekiq.
  # Based on this, you can search/filter for jobs.  Here's an
  # example where I'm selecting all jobs of a certain type
  # and deleting them from the retry queue.
  #
  #   r = Sidekiq::ScheduledSet.new
  #   r.select do |retri|
  #     retri.klass == 'Sidekiq::Extensions::DelayedClass' &&
  #     retri.args[0] == 'User' &&
  #     retri.args[1] == 'setup_new_subscriber'
  #   end.map(&:delete)
  class ScheduledSet < SortedSet
    def initialize
      super 'schedule'
    end
  end

  ##
  # Allows enumeration of retries within Sidekiq.
  # Based on this, you can search/filter for jobs.  Here's an
  # example where I'm selecting all jobs of a certain type
  # and deleting them from the retry queue.
  #
  #   r = Sidekiq::RetrySet.new
  #   r.select do |retri|
  #     retri.klass == 'Sidekiq::Extensions::DelayedClass' &&
  #     retri.args[0] == 'User' &&
  #     retri.args[1] == 'setup_new_subscriber'
  #   end.map(&:delete)
  class RetrySet < SortedSet
    def initialize
      super 'retry'
    end

    def retry_all
      while size > 0
        each(&:retry)
      end
    end
  end


  ##
  # Programmatic access to the current active worker set.
  #
  # WARNING WARNING WARNING
  #
  # This is live data that can change every millisecond.
  # If you call #size => 5 and then expect #each to be
  # called 5 times, you're going to have a bad time.
  #
  #    workers = Sidekiq::Workers.new
  #    workers.size => 2
  #    workers.each do |name, work, started_at|
  #      # name is a unique identifier per worker
  #      # work is a Hash which looks like:
  #      # { 'queue' => name, 'run_at' => timestamp, 'payload' => msg }
  #      # started_at is a String rep of the time when the worker started working on the job
  #    end

  class Workers
    include Enumerable

    def each(&block)
      Sidekiq.redis do |conn|
        workers = conn.smembers("workers")
        workers.each do |w|
          msg, time = conn.multi do
            conn.get("worker:#{w}")
            conn.get("worker:#{w}:started")
          end
          next unless msg
          block.call(w, Sidekiq.load_json(msg), time)
        end
      end
    end

    def size
      Sidekiq.redis do |conn|
        conn.scard("workers")
      end.to_i
    end
  end

end
