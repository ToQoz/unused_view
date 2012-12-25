$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "unused_view/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "unused_view"
  s.version     = UnusedView::VERSION
  s.authors     = ["Takatoshi Matsumoto"]
  s.email       = ["toqoz403@gmail.com"]
  s.homepage    = "http://github.com/ToQoz/unused_view"
  s.summary     = "Rails plugin to see unused views"
  s.description = "This is a Rails plugin to see unused views in you controllers"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 3.2"
  s.add_dependency "console_command", ">= 0.0.2"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end
