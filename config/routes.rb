OmbuLabs::Auth::Engine.routes.draw do
  devise_for OmbuLabs::Auth.users_table_name, class_name: OmbuLabs::Auth.user_class_name, module: :devise, controllers: { omniauth_callbacks: 'ombu_labs/auth/callbacks' }
end
