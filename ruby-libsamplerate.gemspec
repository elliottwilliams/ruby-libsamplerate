# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby-libsamplerate/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby-libsamplerate"
  spec.version       = SRC::VERSION
  spec.authors       = ["Elliott Williams"]
  spec.email         = ["e@elliottwillia.ms"]
  spec.description   = %q{Ruby binding for libsamplerate (aka "Secret Rabbit Code"). libsamplerate is an audio sample rate converter -- it adjusts the sample rate of raw audio.}
  spec.summary       = %q{Ruby binding for libsamplerate, an audio resampling library.}
  spec.homepage      = "http://github.com/elliottwilliams/ruby-libsamplerate"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency "ffi"
end
