# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ext_ipaddr/version'

Gem::Specification.new do |spec|
  spec.name          = "ext_ipaddr"
  spec.version       = ExtIPAddr::VERSION
  spec.authors       = ["Shu Sugimoto"]
  spec.email         = ["shu@su.gimo.to"]
  spec.licenses      = ['MIT']

  spec.summary       = %q{Monkey patch for ruby built-in IPAddr class to make it support CIDR notation}
  spec.description   = %q{Monkey patch for ruby built-in IPAddr class to make it support CIDR notation}
  spec.homepage      = "https://github.com/s2ugimot/ext_ipaddr"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "test-unit"
end
