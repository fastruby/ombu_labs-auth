module OmbuLabs
  module Auth
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
