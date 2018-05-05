# -*- encoding: utf-8 -*-
# frozen_string_literal: true

# allows bundler to use the gemspec for dependencies
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'case_transform/version'

Gem::Specification.new do |s|
  s.name        = 'case_transform'
  s.version     = CaseTransform::VERSION
  s.platform    = Gem::Platform::RUBY
  s.license     = 'MIT'
  s.authors     = ['L. Preston Sego III', 'Ben Mills']
  s.email       = 'LPSego3+dev@gmail.com'
  s.homepage    = 'https://github.com/NullVoxPopuli/case_transform'
  s.summary     = "CaseTransform-#{CaseTransform::VERSION}"
  s.description = 'Extraction of the key_transform abilities of ActiveModelSerializers'

  s.files        = Dir['CHANGELOG.md', 'LICENSE', 'README.md', 'lib/**/*']
  s.require_path = 'lib'

  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  s.required_ruby_version = '>= 2.0'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'pry'
end
