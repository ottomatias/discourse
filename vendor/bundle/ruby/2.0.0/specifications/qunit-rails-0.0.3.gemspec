# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "qunit-rails"
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Francesco Rodriguez"]
  s.date = "2013-01-28"
  s.description = "Qunit for Rails 3.2+"
  s.email = ["lrodriguezsanc@gmail.com"]
  s.extra_rdoc_files = ["CHANGELOG.md", "LICENSE.md", "README.md"]
  s.files = ["CHANGELOG.md", "LICENSE.md", "README.md"]
  s.homepage = "https://github.com/frodsan/qunit-rails"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.2")
  s.rubygems_version = "2.0.3"
  s.summary = "Qunit for Rails 3.2+"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<railties>, [">= 3.2.3"])
    else
      s.add_dependency(%q<railties>, [">= 3.2.3"])
    end
  else
    s.add_dependency(%q<railties>, [">= 3.2.3"])
  end
end
