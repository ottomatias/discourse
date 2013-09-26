# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "sorcerer"
  s.version = "0.3.10"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jim Weirich"]
  s.date = "2013-02-06"
  s.description = "Generate the original Ruby source from a Ripper-style abstract syntax tree."
  s.email = "jim.weirich@gmail.com"
  s.homepage = "http://github.com/jimweirich/sorcerer"
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Rake -- Ruby Make"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "sorcerer"
  s.rubygems_version = "2.0.3"
  s.summary = "Generate Source from Ripper ASTs"
end
