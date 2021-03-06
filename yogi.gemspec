# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yogi/version'

Gem::Specification.new do |spec|
  spec.name          = "yogi"
  spec.version       = Yogi::VERSION
  spec.authors       = ["Thomas Langnickel"]
  spec.email         = ["Langnickel.thomas@gmail.com"]

  spec.description   = %q{The Master of Syntax Error brings you... this debugging exercise
  type "activate" to start the exercise, happy ...debugging your project
  type "checkme" for an update on your debugging progress, or if your are sick of it just type "fixme" to fix the errors}
  spec.summary       = %q{practice debugging skills}
  spec.homepage      = "https://github.com/Yogibeer2001/Yogify"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "https://rubygems.org"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  # spec.bindir        = "exe"
  spec.executables   = ["activate" , "fixme", "checkme"]
  #spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "os"
end
