# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "in_threads"
  s.version = "1.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ivan Kuchin"]
  s.date = "2011-12-13"
  s.homepage = "http://github.com/toy/in_threads"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "in_threads"
  s.rubygems_version = "2.0.3"
  s.summary = "Execute ruby code in parallel"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
