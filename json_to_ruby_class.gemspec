# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'json_to_ruby_class/version'

Gem::Specification.new do |spec|
  spec.name          = "json_to_ruby_class"
  spec.version       = JsonToRubyClass::VERSION
  spec.authors       = ["Vasilis Kalligas"]
  spec.email         = ["billkall@gmail.com"]

  spec.summary       = %q{This gem can be used in Rails apps to automatically convert a json to the relative model classes}
  spec.homepage      = "https://rubygems.org/gems/json_to_ruby_class"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport'
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
