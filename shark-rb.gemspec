# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: shark-rb 0.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "shark-rb"
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jonathan Raiman"]
  s.date = "2014-01-31"
  s.description = "Shark C++ library bindings in Ruby implementing RealVector, LabeledData, UnlabeledData, neural nets and much more!"
  s.email = "jraiman@mit.edu"
  s.extensions = ["ext/extconf.rb"]
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    "README.md",
    "Rakefile",
    "VERSION",
    "ext/Makefile",
    "ext/Optimizer.cpp",
    "ext/Optimizer.h",
    "ext/data/images.csv",
    "ext/extconf.rb",
    "ext/rb_BFGS.h",
    "ext/rb_BinaryCD.cpp",
    "ext/rb_BinaryCD.h",
    "ext/rb_BinaryRBM.h",
    "ext/rb_GaussianBinaryRBM.h",
    "ext/rb_LBFGS.h",
    "ext/rb_LinearModel.cpp",
    "ext/rb_LinearModel.h",
    "ext/rb_PCA.cpp",
    "ext/rb_PCA.h",
    "ext/rb_RealMatrix.cpp",
    "ext/rb_RealMatrix.h",
    "ext/rb_RealVector.cpp",
    "ext/rb_RealVector.h",
    "ext/rb_RegressionDataset.cpp",
    "ext/rb_RegressionDataset.h",
    "ext/rb_Rprop.h",
    "ext/rb_SteepestDescent.cpp",
    "ext/rb_SteepestDescent.h",
    "ext/rb_UnlabeledData.cpp",
    "ext/rb_UnlabeledData.h",
    "ext/rb_classes.h",
    "ext/rb_conversions.cpp",
    "ext/rb_conversions.h",
    "ext/rb_shark.bundle",
    "ext/rb_shark.cpp",
    "lib/autoencoder_text/autoencoder_text.rb",
    "lib/conversion_text/conversion_text.rb",
    "lib/datatypes/datatypes.rb",
    "lib/pca_text/pca_text.rb",
    "lib/shark-rb.rb",
    "shark-rb.gemspec"
  ]
  s.homepage = "http://github.com/JonathanRaiman/shark_rb"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.11"
  s.summary = "Shark C++ library bindings in Ruby."
end

