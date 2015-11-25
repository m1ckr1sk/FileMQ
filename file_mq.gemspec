# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'file_mq/version'

Gem::Specification.new do |spec|
  spec.name          = 'file_mq'
  spec.version       = FileMQ::VERSION
  spec.authors       = ['Mike Butt']
  spec.email         = ['mjbutt@hotmail.co.uk']
  spec.summary       = 'A message queue library based on RabbitMQ that stores messages on file system'
  spec.homepage      = 'https://github.com/m1ckr1sk/FileMQ'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split('\x0')
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'cucumber', '~> 2.0.2'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
