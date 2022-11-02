# frozen_string_literal: true
Devise.setup do |config|
  config.parent_controller = 'OmbuLabs::Auth::ApplicationController'

  if ENV["GITHUB_APP_ID"].present? && ENV["GITHUB_APP_SECRET"]
    config.omniauth :github, ENV["GITHUB_APP_ID"], ENV["GITHUB_APP_SECRET"], scope: "user:email"
  end

  if ENV["SHOW_DEVELOPER_AUTH"].present?
    config.omniauth :developer, scope: "user:email"
  end

  config.router_name = :ombu_labs_auth

  require "devise/orm/active_record"
end
