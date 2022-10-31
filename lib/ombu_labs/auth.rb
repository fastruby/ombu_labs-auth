# due to boot time configs, these need to be required BEFORE the engine
require "devise"
require "omniauth-github"
require "ombu_labs/auth/engine"
require "ombu_labs/auth/version"
require "omniauth/rails_csrf_protection"

module OmbuLabs
  module Auth
    mattr_accessor :user_class_name

    def self.user_class_name
      @@user_class_name || 'User'
    end

    def self.user_class
      @@user_class ||= user_class_name.constantize
    end
  end
end
