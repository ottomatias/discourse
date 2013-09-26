# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "sidetiq"
  s.version = "0.3.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tobias Svensson"]
  s.date = "2013-08-13"
  s.description = "Recurring jobs for Sidekiq"
  s.email = ["tob@tobiassvensson.co.uk"]
  s.homepage = "http://github.com/tobiassvn/sidetiq"
  s.licenses = ["3-clause BSD"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.3"
  s.summary = "Recurring jobs for Sidekiq"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sidekiq>, ["~> 2.13.0"])
      s.add_runtime_dependency(%q<ice_cube>, ["~> 0.11.0"])
    else
      s.add_dependency(%q<sidekiq>, ["~> 2.13.0"])
      s.add_dependency(%q<ice_cube>, ["~> 0.11.0"])
    end
  else
    s.add_dependency(%q<sidekiq>, ["~> 2.13.0"])
    s.add_dependency(%q<ice_cube>, ["~> 0.11.0"])
  end
end
