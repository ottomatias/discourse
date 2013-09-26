require 'mock_redis/assertions'
require 'mock_redis/utility_methods'

class MockRedis
  module HashMethods
    include Assertions
    include UtilityMethods

    def hdel(key, field)
      with_hash_at(key) do |hash|
        if field.is_a?(Array)
          orig_size = hash.size
          hash.delete_if { |k,v| field.include?(k) }
          orig_size - hash.size
        else
          hash.delete(field.to_s) ? 1 : 0
        end
      end
    end

    def hexists(key, field)
      with_hash_at(key) {|h| h.has_key?(field.to_s)}
    end

    def hget(key, field)
      with_hash_at(key) {|h| h[field.to_s]}
    end

    def hgetall(key)
      with_hash_at(key) {|h| h}
    end

    def hincrby(key, field, increment)
      with_hash_at(key) do |hash|
        field = field.to_s
        unless can_incr?(data[key][field])
          raise Redis::CommandError, "ERR hash value is not an integer"
        end
        unless looks_like_integer?(increment.to_s)
          raise Redis::CommandError, "ERR value is not an integer or out of range"
        end

        new_value = (hash[field] || "0").to_i + increment.to_i
        hash[field] = new_value.to_s
        new_value
      end
    end

    def hkeys(key)
      with_hash_at(key, &:keys)
    end

    def hlen(key)
      hkeys(key).length
    end

    def hmget(key, *fields)
      assert_has_args(fields, 'hmget')
      fields.map{|f| hget(key, f)}
    end

    def mapped_hmget(key, *fields)
      reply = hmget(key, *fields)
      Hash[*fields.zip(reply).flatten]
    end

    def hmset(key, *kvpairs)
      assert_has_args(kvpairs, 'hmset')
      if kvpairs.length.odd?
        raise Redis::CommandError, "ERR wrong number of arguments for HMSET"
      end

      kvpairs.each_slice(2) do |(k,v)|
        hset(key, k, v)
      end
      'OK'
    end

    def mapped_hmset(key, hash)
      kvpairs = hash.to_a.flatten
      assert_has_args(kvpairs, 'hmset')
      if kvpairs.length.odd?
        raise Redis::CommandError, "ERR wrong number of arguments for 'hmset' command"
      end

      hmset(key, *kvpairs)
    end

    def hset(key, field, value)
      with_hash_at(key) {|h| h[field.to_s] = value.to_s}
      true
    end

    def hsetnx(key, field, value)
      if hget(key, field)
        false
      else
        hset(key, field, value)
        true
      end
    end

    def hvals(key)
      with_hash_at(key, &:values)
    end

    private

    def with_hash_at(key, &blk)
      with_thing_at(key, :assert_hashy, proc {{}}, &blk)
    end

    def hashy?(key)
      data[key].nil? || data[key].kind_of?(Hash)
    end

    def assert_hashy(key)
      unless hashy?(key)
        raise Redis::CommandError, "ERR Operation against a key holding the wrong kind of value"
      end
    end

  end
end
