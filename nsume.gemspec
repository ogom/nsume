# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nsume/version'

Gem::Specification.new do |spec|
  spec.name          = "nsume"
  spec.version       = Nsume::VERSION
  spec.authors       = ["ogom"]
  spec.email         = ["ogom@hotmail.co.jp"]
  spec.summary       = %q{naturally consume.}
  spec.description   = %q{naturally consume by ruby.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 0.18"
  spec.add_dependency "faraday", "~> 0.9"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
