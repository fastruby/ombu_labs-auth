ENV["SHOW_DEVELOPER_AUTH"] = "true"
ENV["GITHUB_APP_ID"] = "1234"
ENV["GITHUB_APP_SECRET"] = "1234"
ENV["ORGANIZATION_LOGIN"] = "my_org"

# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!
