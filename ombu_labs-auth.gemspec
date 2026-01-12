require_relative "lib/ombu_labs/auth/version"

Gem::Specification.new do |spec|
  spec.name        = "ombu_labs-auth"
  spec.version     = OmbuLabs::Auth::VERSION
  spec.authors     = ["OmbuLabs"]
  spec.email       = ["ernesto@ombulabs.com"]
  spec.homepage    = "https://github.com/fastruby/ombu_labs-auth"
  spec.summary     = "OmbuLabs.ai's internal authentication gem"
  spec.description = "Helps us authenticate teammates using Oauth and Devise (Google Workspace and GitHub)"
  spec.license     = "MIT"
  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  # spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/fastruby/ombu_labs-auth"
  spec.metadata["changelog_uri"] = "https://github.com/fastruby/ombu_labs-auth/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 6.0", "< 9.0"
  spec.add_dependency "devise", "~> 4.9"
  spec.add_dependency "omniauth", "~> 2.1.0"
  spec.add_dependency "omniauth-github", "~> 2.0.0"
  spec.add_dependency "omniauth-google-oauth2", "~> 1.1"
  spec.add_dependency "omniauth-rails_csrf_protection"
  spec.add_development_dependency "capybara"
  spec.add_development_dependency "selenium-webdriver", ">= 4.11"
  spec.add_development_dependency "puma"
end
