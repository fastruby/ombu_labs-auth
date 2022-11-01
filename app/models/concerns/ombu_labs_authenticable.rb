require "active_support/concern"

module OmbuLabsAuthenticable
  extend ActiveSupport::Concern
  
  included do
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable
    devise :database_authenticatable, :omniauthable
  end

  class_methods do    
    def from_omniauth(auth)
      user_attributes = {
        email: auth["info"]["email"],
        name: auth["info"]["name"],
        password: Devise.friendly_token[0, 20]
      }
      where(provider: auth["provider"], uid: auth["uid"]).first_or_create.tap { |user| user.update(user_attributes) }
    end
  end
end