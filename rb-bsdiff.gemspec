# -*- encoding: utf-8 -*-
# WARNING: This file is auto-generated via 'rake gemspec'!  DO NOT EDIT BY HAND!

Gem::Specification.new do |s|
  s.name = "rb-bsdiff"
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Todd Fisher", "Jon Frisby"]
  s.date = "2012-12-17"
  s.description = "Ruby bindings to bindary diff tools bsdiff and bspatch"
  s.email = "todd.fisher@gmail.com jon@cloudability.com"
  s.extensions = ["ext/extconf.rb"]
  s.files = ["README", "ext/b0", "ext/b1", "ext/bsdiff.c", "ext/bsdiff.h", "ext/bspatch.c", "ext/bspatch.h", "ext/extconf.rb", "ext/rb_bsdiff.c", "rb-bsdiff.gemspec"]
  s.homepage = "http://github.com/cloudability/rb-bsdiff"
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "rb-bsdiff"
  s.rubygems_version = "1.8.24"
  s.summary = "Ruby bindings to bindary diff tools bsdiff and bspatch"

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
