# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'templatable/version'

Gem::Specification.new do |spec|
  spec.name          = "templatable"
  spec.version       = Templatable::VERSION
  spec.authors       = ["tbpgr"]
  spec.email         = ["tbpgr@tbpgr.jp"]
  spec.description   = %q{Templatable is CLI tool that generate ruby-source-code using ERB template.}
  spec.summary       = %q{Templatable is CLI tool that generate ruby-source-code using ERB template.}
  spec.homepage      = "https://github.com/tbpgr/templatable"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "thor", "~> 0.18.1"
  spec.add_runtime_dependency "activesupport", "~> 4.0.1"
  spec.add_runtime_dependency "activemodel", "~> 4.0.2"
  spec.add_runtime_dependency "tbpgr_utils", "~> 0.0.5"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "simplecov"
end
