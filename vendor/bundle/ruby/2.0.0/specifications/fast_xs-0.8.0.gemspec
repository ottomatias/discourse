# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "fast_xs"
  s.version = "0.8.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["fast_xs hackers"]
  s.date = "2011-01-26"
  s.description = "fast_xs provides C extensions for escaping text.\n\nThe original String#fast_xs method is based on the xchar code by Sam Ruby:\n\n* http://intertwingly.net/stories/2005/09/28/xchar.rb\n* http://intertwingly.net/blog/2005/09/28/XML-Cleansing\n\n_why also packages an older version with Hpricot (patches submitted).\nThe version here should be compatible with the latest version of Hpricot\ncode.\n\nRuby on Rails will automatically use String#fast_xs from either Hpricot\nor this gem version with the bundled Builder package.\n\nString#fast_xs is an almost exact translation of Sam Ruby's original\nimplementation (String#to_xs), but it does escape \"&quot;\" (which is an\noptional, but all parsers are able ot handle it.  XML::Builder as\npackaged in Rails 2.0 will be automatically use String#fast_xs instead\nof String#to_xs available."
  s.email = "fast-xs-general@rubyforge.org"
  s.extensions = ["ext/fast_xs/extconf.rb", "ext/fast_xs_extra/extconf.rb"]
  s.extra_rdoc_files = ["Manifest.txt"]
  s.files = ["Manifest.txt", "ext/fast_xs/extconf.rb", "ext/fast_xs_extra/extconf.rb"]
  s.homepage = "http://fast-xs.rubyforge.org/"
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "fast-xs"
  s.rubygems_version = "2.0.3"
  s.summary = "fast_xs provides C extensions for escaping text"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hoe>, [">= 2.8.0"])
    else
      s.add_dependency(%q<hoe>, [">= 2.8.0"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 2.8.0"])
  end
end
