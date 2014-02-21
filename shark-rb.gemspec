# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: shark-rb 1.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "shark-rb"
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jonathan Raiman"]
  s.date = "2014-02-21"
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
    "ext/extras/matrix/rb_matrix_methods.extras",
    "ext/extras/models/rb_abstract_model.extras",
    "ext/extras/models/rb_objective_function.extras",
    "ext/extras/rbm/rb_neuronlayer_bias.extras",
    "ext/extras/rbm/rb_rbm_neuronlayer.extras",
    "ext/extras/utils/rb_datatype_deep_copy.extras",
    "ext/extras/utils/rb_pointer_wrapping.extras",
    "ext/extras/vector/rb_vector_length.extras",
    "ext/extras/vector/rb_vector_methods.extras",
    "ext/extras/vector/rb_vector_min_methods.extras",
    "ext/extras/vector/rb_vector_resize.extras",
    "ext/rb_BFGS.h",
    "ext/rb_BarsAndStripes.cpp",
    "ext/rb_BarsAndStripes.h",
    "ext/rb_BinaryCD.cpp",
    "ext/rb_BinaryCD.h",
    "ext/rb_BinaryRBM.cpp",
    "ext/rb_BinaryRBM.h",
    "ext/rb_ExactGradient.cpp",
    "ext/rb_ExactGradient.h",
    "ext/rb_GaussianBinaryRBM.h",
    "ext/rb_LBFGS.cpp",
    "ext/rb_LBFGS.h",
    "ext/rb_LinearModel.cpp",
    "ext/rb_LinearModel.h",
    "ext/rb_PCA.cpp",
    "ext/rb_PCA.h",
    "ext/rb_RBMBinaryLayer.cpp",
    "ext/rb_RBMBinaryLayer.h",
    "ext/rb_RBM_Analytics.cpp",
    "ext/rb_RBM_Analytics.h",
    "ext/rb_RealMatrix.cpp",
    "ext/rb_RealMatrix.h",
    "ext/rb_RealMatrixColumn.cpp",
    "ext/rb_RealMatrixColumn.h",
    "ext/rb_RealMatrixReference.cpp",
    "ext/rb_RealMatrixReference.h",
    "ext/rb_RealMatrixRow.cpp",
    "ext/rb_RealMatrixRow.h",
    "ext/rb_RealVector.cpp",
    "ext/rb_RealVector.h",
    "ext/rb_RealVectorReference.cpp",
    "ext/rb_RealVectorReference.h",
    "ext/rb_RegressionDataset.cpp",
    "ext/rb_RegressionDataset.h",
    "ext/rb_Rprop.h",
    "ext/rb_SolutionSet.cpp",
    "ext/rb_SolutionSet.h",
    "ext/rb_SteepestDescent.cpp",
    "ext/rb_SteepestDescent.h",
    "ext/rb_UnlabeledData.cpp",
    "ext/rb_UnlabeledData.h",
    "ext/rb_classes.h",
    "ext/rb_conversions.cpp",
    "ext/rb_conversions.h",
    "ext/rb_matrix_methods.extras",
    "ext/rb_shark.bundle",
    "ext/rb_shark.cpp",
    "lib/autoencoder_text/autoencoder_text.rb",
    "lib/binaryrbm_text/binaryrbm_text.rb",
    "lib/conversion_text/conversion_text.rb",
    "lib/datatypes/datatypes.rb",
    "lib/deep_belief_network/DBN.rb",
    "lib/deep_belief_network/HiddenLayer.rb",
    "lib/deep_belief_network/deep_belief_network.rb",
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

