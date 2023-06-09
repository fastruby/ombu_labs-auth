# OmbuLabs::Auth

This gem provides an easy way to generate new (Devise) sessions for members of a GitHub organization.

If a user is signing in with GitHub and they are a (public) member of the configured GitHub organization, they will be allowed in.

## Environment Variables

### GitHub Login

Make sure you configure your ENV variables to use Github authentication.

```
ENV["GITHUB_APP_ID"]
ENV["GITHUB_APP_SECRET"]
ENV["ORGANIZATION_LOGIN"]
```

`ORGANIZATION_LOGIN`: This is the organization name as it appears in the GitHub URL, for instance `orgname` in https://github.com/orgname. It is needed to check if users are a part of the organization. Ensure that your membership is set to _public_ when you visit https://github.com/orgs/orgname/people.

If you don't belong to any organization, you can set up one here: https://github.com/organizations/plan

Make sure you add your organization to the `.env` file like this:

```
ORGANIZATION_LOGIN=orgname
```

`GITHUB_APP_ID` and `GITHUB_APP_SECRET`: These are the credentials of the OAuth GitHub App that you need to create. Follow the instructions on this link to create one: [Creating an OAuth GitHub App](https://docs.github.com/en/developers/apps/building-oauth-apps/creating-an-oauth-app)

When creating the OAuth GitHub App, the `Homepage URL` field should be set to http://localhost:3000, and the `Authorization callback URL` should be http://localhost:3000/users/auth/github/callback.

Once you create the app and generate credentials for it, make sure you add them to the `.env` file like this:

```
GITHUB_APP_ID=xxxxxxxxxxxxxxxxxxxx
GITHUB_APP_SECRET=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

### Developer Login

To avoid the need of a GitHub application setup (useful for local development or Heroku Review Apps), the `developer` strategy can be enabled using setting a `SHOW_DEVELOPER_AUTH` variable with any non-blank value (`SHOW_DEVELOPER_AUTH=1` or `SHOW_DEVELOPER_AUTH=true` for example).

## Getting Started

### Requirements

A `User`-like model that will be used for the authentication (`User`, `Admin`, `Client`, etc).

The database table for that model must have, at least, these fields:

```rb
create_table :clients do |t|
  t.string :email, unique: true
  t.string :provider
  t.string :uid, unique: true
  t.string :name
  t.string :encrypted_password
end
```

### Installation

- Add this line to your application's Gemfile:

```ruby
gem 'ombu_labs-auth'
```

- And then execute:

```bash
$ bundle
```

- Add the following line to `config/routes.rb`

```ruby
mount OmbuLabs::Auth::Engine, at: '/', as: 'ombu_labs_auth'
```

- Add a Devise signin link in your homepage (notice all URL helpers will be under the engine object `ombu_labs_auth`)

```html
<div>
  <h1>Welcome to the App</h1>
  <%= link_to "Sign in", ombu_labs_auth.new_user_session_path %>
</div>
```

> This will default to a basic HTML page included in this gem. To customize this view, check [this section](#customizing-sign-in-page)

- Add the Devise authentication helper to your private objects controllers

```rb
before_action :authenticate_user!
```

- Include the `OmbuLabsAuthenticable` concern in the authenticable model

```rb
class Admin < ApplicationRecord
  include OmbuLabsAuthenticable
  ...
end
```

- Tell `OmbuLabs::Auth` the user class name and table for the authenticable model

```rb
# config/initializers/ombu_labs-auth.rb
OmbuLabs::Auth.user_class_name = "Admin" # defaults to "User" if not set
OmbuLabs::Auth.users_table_name = :admins # defaults to :users if not set
```

> You can skip this step if the table is called `users` and the model is called `User`

- Log Out action

A link to `ombu_labs_auth.destroy_user_session_path` with method `DELETE` can be used. If rails-ujs is not available, a `button_to` can be used.

```
<%= link_to "Sign out", ombu_labs_auth.destroy_user_session_path, method: :delete, class: "button magenta" %>
```

### TODO: create a rails template to do all the previous steps automatically

## Customizing sign in page

The gem provides a basic html template to select the authentication method. To customize it, create a view at `views/devise/session/new.html.erb` and a layout at `views/layouts/devise.html.erb`.

Include this snippet in the `new` view:

```
<%- Devise.omniauth_providers.each do |provider| %>
  <%= button_to "Sign in with #{OmniAuth::Utils.camelize(provider)}", omniauth_authorize_path(OmbuLabs::Auth.user_class, provider), method: :post %><br />
<% end -%>
```

To use a `link_to` helper instead of a `button_to` helper to, rails-ujs is needed to support making a `POST` request with link tags. Then, replace with:

```
<%= link_to "Sign in with #{OmniAuth::Utils.camelize(provider)}", omniauth_authorize_path(OmbuLabs::Auth.user_class, provider), method: :post, data: { 'turbo-method' => :post } %><br />
```

> If this intermediate page is not needed, the button/link to `omniauth_authorize_path` can be used directly.

## Running tests

Run `rake app:test:all` to run all tests and `rake app:test` to skip system tests.

## Caveats

Please be aware this gem is a mountable engine which depends on Devise, and it's not possible to mount it multiple times. Refer to their Wiki for more on the issue - https://github.com/heartcombo/devise/wiki/How-To:-Use-devise-inside-a-mountable-engine

## Contributing

Have a fix for a problem you've been running into or an idea for a new feature you think would be useful?

Take a look at the [Contributing document](https://github.com/fastruby/ombu_labs-auth/blob/main/CONTRIBUTING.md) for instructions to set up the repo on your machine and create a good Pull Request.

## Release

If you are looking to contribute in the gem you need to be aware that we are using the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/#summary) specification to release versions in this gem.

which means, when doing a contribution your commit message must have the following structure

```git
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

[here](https://www.conventionalcommits.org/en/v1.0.0/#examples) you can find some commit's examples.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
