# OmbuLabs::Auth
> _Refactor a rack middleware (probably a ruby gem) out of https://points.ombulabs.com/ so that we can easily add GitHub-based authentication to other Ruby/Rails internal applications._
>
> _It would be useful if we could add it to http://skunk.fastruby.io (backend for skunk) so that anybody who is part of our organization could sign in and review details in the admin panel._
>
> _Said gem should be easily configurable (only with environment variables) and should make it very simple to add "OmbuLabs-authentication" to our internal Ruby apps._

## Configs
Make sure you configure your ENV variables to use Github authentication.

```
ENV["GITHUB_APP_ID"]
ENV["GITHUB_APP_SECRET"]
ENV["ORGANIZATION_LOGIN"]
```
## Installation

- Clone this gem inside the `lib` folder of your project


- Add these lines to your application's Gemfile:

```ruby
gem 'ombu_labs-auth', path: 'lib/ombu_labs-auth'
gem 'omniauth-github', '~> 2.0.0'
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

- Add the Devise authentication helper to your private objects controllers

```
before_action :authenticate_user!
```

## Usage
_TODO_

## Caveats

Please be aware this gem is a mountable engine which depends on Devise, and it's not possible to mount it multiple times. Refer to their Wiki for more on the issue - https://github.com/heartcombo/devise/wiki/How-To:-Use-devise-inside-a-mountable-engine

## Contributing
_TODO_

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
