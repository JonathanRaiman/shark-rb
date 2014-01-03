# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: shark-rb 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "shark-rb"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jonathan Raiman"]
  s.date = "2014-01-03"
  s.email = "jraiman@mit.edu"
  s.extensions = ["ext/extconf.rb"]
  s.files = [
    "Rakefile",
    "VERSION",
    "ext/Makefile",
    "ext/Optimizer.cpp",
    "ext/Optimizer.h",
    "ext/data/images.csv",
    "ext/extconf.rb",
    "ext/rb_shark.cpp",
    "ext/shark.bundle",
    "lib/shark-rb.rb",
    "shark-rb.gemspec"
  ]
  s.homepage = "http://github.com/JonathanRaiman/shark_rb"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.10"
  s.summary = "Shark C++ library bindings in Ruby."
end

