# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'super_sync/version'

Gem::Specification.new do |spec|
  spec.name          = "super_sync"
  spec.version       = SuperSync::VERSION
  spec.authors       = ["ruvido"]
  spec.email         = ["ruvido@gmail.com"]

  spec.summary       = %q{Super Sync SD}
  spec.description   = %q{Super Sync SD}
  spec.homepage      = "ruvido.github.io/super_sync"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake" #, "~> 10.0"

  spec.add_dependency 'ruby-progressbar'

end
