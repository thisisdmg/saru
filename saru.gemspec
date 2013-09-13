# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'saru/version'

Gem::Specification.new do |spec|
  spec.name          = 'saru'
  spec.version       = Saru::VERSION
  spec.authors       = ['Tobias Bühlmann']
  spec.email         = ['t.buehlmann@thisisdmg.com']
  spec.description   = 'Object related authorization library.'
  spec.summary       = "Saru is an extraction of Ryan Bates' famous authorization library CanCan. As it is not _really_ maintained anymore, we decided to extract the crucial portions from it, fixing and improving them for our needs."
  spec.homepage      = 'https://github.com/thisisdmg/saru'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(/^spec/)
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '~> 10.1'
  spec.add_development_dependency 'rspec', '~> 2.14'
  spec.add_development_dependency 'pry', '>= 0.9.12.2'
end
