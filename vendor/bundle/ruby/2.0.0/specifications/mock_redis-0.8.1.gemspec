# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "mock_redis"
  s.version = "0.8.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Causes Engineering", "Samuel Merritt"]
  s.date = "2013-06-28"
  s.description = "Instantiate one with `redis = MockRedis.new` and treat it like you would a normal Redis object. It supports all the usual Redis operations."
  s.email = ["eng@causes.com"]
  s.homepage = "https://github.com/causes/mock_redis"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.3"
  s.summary = "Redis mock that just lives in memory; useful for testing."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, ["~> 0.9.2"])
      s.add_development_dependency(%q<redis>, ["~> 3.0.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.6.0"])
    else
      s.add_dependency(%q<rake>, ["~> 0.9.2"])
      s.add_dependency(%q<redis>, ["~> 3.0.0"])
      s.add_dependency(%q<rspec>, ["~> 2.6.0"])
    end
  else
    s.add_dependency(%q<rake>, ["~> 0.9.2"])
    s.add_dependency(%q<redis>, ["~> 3.0.0"])
    s.add_dependency(%q<rspec>, ["~> 2.6.0"])
  end
end
