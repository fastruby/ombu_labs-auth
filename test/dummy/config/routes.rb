Rails.application.routes.draw do
  mount OmbuLabs::Auth::Engine => "/", as: "ombu_labs_auth"

  root to: "users#index"
end
