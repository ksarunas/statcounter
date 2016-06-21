# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'statcounter/version'

Gem::Specification.new do |spec|
  spec.name = 'statcounter'
  spec.platform = Gem::Platform::RUBY
  spec.version = Statcounter::VERSION
  spec.authors = ['Šarūnas Kūjalis']
  spec.email = ['sarjalis@gmail.com']
  spec.summary = 'Ruby Statcounter API wrapper'
  spec.homepage = 'https://github.com/ksarunas/statcounter'

  spec.files = `git ls-files`.split($/)
  spec.test_files = `git ls-files -- {spec}/*`.split("\n")
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
