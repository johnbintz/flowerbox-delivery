# -*- encoding: utf-8 -*-
require File.expand_path('../lib/flowerbox/delivery/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["John Bintz"]
  gem.email         = ["john@coswellproductions.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "flowerbox-delivery"
  gem.require_paths = ["lib"]
  gem.version       = Flowerbox::Delivery::VERSION

  gem.add_development_dependency 'cucumber'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'jquery-rails', '~> 1.0.0'
  gem.add_development_dependency 'mocha'
  gem.add_development_dependency 'fakefs'
  gem.add_development_dependency 'nokogiri'
  gem.add_development_dependency 'therubyracer'
  gem.add_development_dependency 'sass'
  gem.add_development_dependency 'ejs'

  gem.add_runtime_dependency 'rack'
  gem.add_runtime_dependency 'sprockets'
  gem.add_runtime_dependency 'coffee-script'
end
