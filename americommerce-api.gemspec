$:.push File.expand_path("../lib", __FILE__)
require "americommerce/version"
Gem::Specification.new do |s|
  s.name     = "americommerce-api"
  s.version  = Americommerce::VERSION
  s.date     = Time.now.strftime("%Y-%m-%d")
  s.summary  = "Enables Ruby applications to communicate with the Americommerce API"
  s.email    = "omri@yotpo.com"
  s.homepage = "https://github.com/YotpoLtd/americommerce-api"
  s.description = "Enables Ruby applications to communicate with the Ebay Trading API."
  s.has_rdoc = false
  s.require_paths = ['lib']
  s.authors  = ["Yotpo/avichay@yotpo"]
  s.files = ["README.md", "americommerce-api.gemspec"] + Dir['**/*.rb'] + Dir['**/*.crt']
  s.add_dependency 'savon'
end