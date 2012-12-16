# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "rddd-monitor"
  s.version     = '0.1.3'
  s.authors     = ["Petr Janda"]
  s.email       = ["petr@ngneers.com"]
  s.homepage    = ""
  s.summary     = 'Monitoring tool for rDDD'
  s.description = 'User inteligence.'

  s.rubyforge_project = "watchr"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_dependency 'sinatra'
  s.add_dependency 'rddd'
end
