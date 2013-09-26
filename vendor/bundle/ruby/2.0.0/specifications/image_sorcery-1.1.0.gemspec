# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "image_sorcery"
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Eric Rafaloff", "Guy Boertje"]
  s.date = "2013-01-17"
  s.description = "A ruby ImageMagick/GraphicsMagick library that doesn't suck"
  s.email = ["hello@ericrafaloff.com", "guy@musicglue.com"]
  s.homepage = "https://github.com/EricR/image_sorcery"
  s.require_paths = ["lib"]
  s.requirements = ["ImageMagick or GraphicsMagick"]
  s.rubygems_version = "2.0.3"
  s.summary = "A ruby ImageMagick/GraphicsMagick library that doesn't suck"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.12.0"])
      s.add_development_dependency(%q<rake>, ["~> 10.0.2"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.12.0"])
      s.add_dependency(%q<rake>, ["~> 10.0.2"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.12.0"])
    s.add_dependency(%q<rake>, ["~> 10.0.2"])
  end
end
