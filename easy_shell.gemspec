# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'easy_shell/version'

Gem::Specification.new do |gem|
  gem.name          = "easy_shell"
  gem.version       = EasyShell::VERSION
  gem.authors       = ["Harlan T Wood"]
  gem.email         = ["code@harlantwood.net"]
  gem.description   = %q{Execute shell commands, with options like verbose output, confirm first, and continue or stop on failure}
  gem.summary       = gem.description
  gem.homepage      = "https://github.com/harlantwood/easy_shell"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
