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

  spec.add_dependency 'faraday', '>= 0.8'
  spec.add_dependency 'faraday_middleware', '0.12.2'

  spec.add_development_dependency 'bundler', '1.16.1'
  spec.add_development_dependency 'rake', '12.3.0'
  spec.add_development_dependency 'rspec', '3.7.0'
  spec.add_development_dependency 'timecop', '0.9.1'
  spec.add_development_dependency 'rack', '2.0.3'
  spec.add_development_dependency 'webmock', '3.2.1'
end
