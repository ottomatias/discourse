# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "redis-store"
  s.version = "1.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Luca Guidi", "Matt Horan"]
  s.date = "2012-10-06"
  s.description = "Namespaced Rack::Session, Rack::Cache, I18n and cache Redis stores for Ruby web frameworks."
  s.email = ["me@lucaguidi.com"]
  s.homepage = "http://jodosha.github.com/redis-store"
  s.require_paths = ["lib"]
  s.rubyforge_project = "redis-store"
  s.rubygems_version = "2.0.3"
  s.summary = "Redis stores for Ruby frameworks"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<redis>, [">= 2.2.0"])
      s.add_development_dependency(%q<rake>, ["~> 0.9.2"])
      s.add_development_dependency(%q<bundler>, ["~> 1.1"])
      s.add_development_dependency(%q<mocha>, ["~> 0.10.0"])
      s.add_development_dependency(%q<minitest>, ["~> 2.8.0"])
      s.add_development_dependency(%q<purdytest>, ["~> 1.0.0"])
      s.add_development_dependency(%q<git>, ["~> 1.2.5"])
    else
      s.add_dependency(%q<redis>, [">= 2.2.0"])
      s.add_dependency(%q<rake>, ["~> 0.9.2"])
      s.add_dependency(%q<bundler>, ["~> 1.1"])
      s.add_dependency(%q<mocha>, ["~> 0.10.0"])
      s.add_dependency(%q<minitest>, ["~> 2.8.0"])
      s.add_dependency(%q<purdytest>, ["~> 1.0.0"])
      s.add_dependency(%q<git>, ["~> 1.2.5"])
    end
  else
    s.add_dependency(%q<redis>, [">= 2.2.0"])
    s.add_dependency(%q<rake>, ["~> 0.9.2"])
    s.add_dependency(%q<bundler>, ["~> 1.1"])
    s.add_dependency(%q<mocha>, ["~> 0.10.0"])
    s.add_dependency(%q<minitest>, ["~> 2.8.0"])
    s.add_dependency(%q<purdytest>, ["~> 1.0.0"])
    s.add_dependency(%q<git>, ["~> 1.2.5"])
  end
end
