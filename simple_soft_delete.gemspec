# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "simple_soft_delete/version"

Gem::Specification.new do |s|
  s.name        = "simple_soft_delete"
  s.version     = SimpleSoftDelete::VERSION
  s.authors     = ["David Batey"]
  s.email       = ["davidlbatey@gmail.com"]
  s.homepage    = "https://github.com/davidlbatey/simple_soft_delete"
  s.summary     = "Simple soft delete for rails"
  s.description = "Flags records as deleted instead of removing them"

  s.rubyforge_project = "simple_soft_delete"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "activerecord", " > 3.0.0"
  s.add_development_dependency "bundler", "~> 1.0.0"
  s.add_development_dependency "rspec", "~> 2.8.0"
  s.add_development_dependency "database_cleaner", "~> 0.7.1"
  s.add_development_dependency "sqlite3-ruby", "~> 1.3.3"

end
