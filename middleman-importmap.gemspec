# -*- encoding: utf-8 -*-
# frozen_string_literal: true

$LOAD_PATH.push(File.expand_path("../lib", __FILE__))

require "middleman-importmap/version"

Gem::Specification.new do |s|
  s.name        = "middleman-importmap"
  s.version     = Middleman::Importmap::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Daniel Vinciguerra"]
  s.email       = ["daniel.vinciguerra@bivee.com.br"]
  s.homepage    = "https://github.com/dvinciguerra/middleman-importmap"
  s.summary     = "Middleman Importmap extension"
  s.description = "An extension to port importmap assets to Middleman"

  s.files         = %x(git ls-files).split("\n")
  s.test_files    = %x(git ls-files -- {test,spec,features}/*).split("\n")
  s.executables   = %x(git ls-files -- bin/*).split("\n").map { |f| File.basename(f) }
  s.require_paths = ["lib"]

  # The version of middleman-core your extension depends on
  s.add_runtime_dependency("middleman-core", [">= 4.4.2"])

  # Additional dependencies
  # s.add_runtime_dependency("gem-name", "gem-version")
end
