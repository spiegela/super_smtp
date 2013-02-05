# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'super_smtp/version'

Gem::Specification.new do |gem|
  gem.name          = "super_smtp"
  gem.version       = SuperSmtp::VERSION
  gem.authors       = ["Aaron Spiegel"]
  gem.email         = ["spiegela@gmail.com"]
  gem.description   = %q{Support Specific Source IP in Net::SMTP}
  gem.summary       = gem.description
  gem.homepage      = "http://www.github.com/spiegela/super_smtp"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
