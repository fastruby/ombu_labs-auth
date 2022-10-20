require_relative "lib/ombu_labs/auth/version"

Gem::Specification.new do |spec|
  spec.name        = "ombu_labs-auth"
  spec.version     = OmbuLabs::Auth::VERSION
  spec.authors     = ["OmbuLabs"]
  spec.email       = ["tiago@ombulabs.com", "ernesto+@ombulabs.com"]
  spec.homepage    = "https://github.com/fastruby/ombu_labs-auth"
  spec.summary     = "OmbuLabs internal authentication gem"
  spec.description = "Helps us authenticate teammates using GitHub Oauth and Devise"
  spec.license     = "MIT"
  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  # spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/fastruby/ombu_labs-auth"
  spec.metadata["changelog_uri"] = "https://github.com/fastruby/ombu_labs-auth/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 6.0"
  spec.add_dependency "devise", "~> 4.8.1"
  spec.add_dependency "omniauth", "~> 2.1.0"
  spec.add_dependency "omniauth-github", "~> 2.0.0"
end
