# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rapid/version'

Gem::Specification.new do |spec|
  spec.name          = "rapidjob"
  spec.version       = Rapid::VERSION
  spec.authors       = ["Arman Sarrafi"]
  spec.email         = ["arman.zrb@gmail.com"]
  spec.description   = %q{RapidJob is a RabbitMQ-backed Ruby library for processing background jobs.}
  spec.summary       = %q{RabbitMQ-backed background jobs}
  spec.homepage      = "https://github.com/armansa/rapidjob"
  spec.license       = "GPLv3"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_dependency "rake"
  spec.add_dependency "amqp"
  spec.add_dependency "json"
  spec.add_dependency "bunny", ">= 2.7.0"
end
