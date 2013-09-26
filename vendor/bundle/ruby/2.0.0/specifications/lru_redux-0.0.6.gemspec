# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "lru_redux"
  s.version = "0.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sam Saffron"]
  s.date = "2013-04-23"
  s.description = "An efficient implementation of an lru cache"
  s.email = ["sam.saffron@gmail.com"]
  s.homepage = ""
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.3"
  s.summary = "An efficient implementation of an lru cache"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
      s.add_development_dependency(%q<guard-minitest>, [">= 0"])
      s.add_development_dependency(%q<guard>, [">= 0"])
      s.add_development_dependency(%q<rb-inotify>, [">= 0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 0"])
      s.add_dependency(%q<guard-minitest>, [">= 0"])
      s.add_dependency(%q<guard>, [">= 0"])
      s.add_dependency(%q<rb-inotify>, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 0"])
    s.add_dependency(%q<guard-minitest>, [">= 0"])
    s.add_dependency(%q<guard>, [">= 0"])
    s.add_dependency(%q<rb-inotify>, [">= 0"])
  end
end
