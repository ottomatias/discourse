# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "redis-actionpack"
  s.version = "3.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Luca Guidi", "Matt Horan"]
  s.date = "2012-04-02"
  s.description = "Redis session store for ActionPack"
  s.email = ["me@lucaguidi.com"]
  s.homepage = "http://jodosha.github.com/redis-store"
  s.require_paths = ["lib"]
  s.rubyforge_project = "redis-actionpack"
  s.rubygems_version = "2.0.3"
  s.summary = "Redis session store for ActionPack"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<redis-store>, ["~> 1.1.0"])
      s.add_runtime_dependency(%q<redis-rack>, ["~> 1.4.0"])
      s.add_runtime_dependency(%q<actionpack>, ["~> 3.2.3"])
      s.add_development_dependency(%q<rake>, ["~> 0.9.2.2"])
      s.add_development_dependency(%q<bundler>, ["~> 1.1.rc"])
      s.add_development_dependency(%q<minitest>, ["~> 2.8.0"])
      s.add_development_dependency(%q<purdytest>, ["~> 1.0.0"])
      s.add_development_dependency(%q<tzinfo>, [">= 0"])
      s.add_development_dependency(%q<mini_specunit>, [">= 0"])
      s.add_development_dependency(%q<mini_backtrace>, [">= 0"])
    else
      s.add_dependency(%q<redis-store>, ["~> 1.1.0"])
      s.add_dependency(%q<redis-rack>, ["~> 1.4.0"])
      s.add_dependency(%q<actionpack>, ["~> 3.2.3"])
      s.add_dependency(%q<rake>, ["~> 0.9.2.2"])
      s.add_dependency(%q<bundler>, ["~> 1.1.rc"])
      s.add_dependency(%q<minitest>, ["~> 2.8.0"])
      s.add_dependency(%q<purdytest>, ["~> 1.0.0"])
      s.add_dependency(%q<tzinfo>, [">= 0"])
      s.add_dependency(%q<mini_specunit>, [">= 0"])
      s.add_dependency(%q<mini_backtrace>, [">= 0"])
    end
  else
    s.add_dependency(%q<redis-store>, ["~> 1.1.0"])
    s.add_dependency(%q<redis-rack>, ["~> 1.4.0"])
    s.add_dependency(%q<actionpack>, ["~> 3.2.3"])
    s.add_dependency(%q<rake>, ["~> 0.9.2.2"])
    s.add_dependency(%q<bundler>, ["~> 1.1.rc"])
    s.add_dependency(%q<minitest>, ["~> 2.8.0"])
    s.add_dependency(%q<purdytest>, ["~> 1.0.0"])
    s.add_dependency(%q<tzinfo>, [">= 0"])
    s.add_dependency(%q<mini_specunit>, [">= 0"])
    s.add_dependency(%q<mini_backtrace>, [">= 0"])
  end
end
