require "test_helper"

class CallbacksControllerTest < ActionDispatch::IntegrationTest
  GITHUB_INFO = {
    "id" => "12345",
    "email" => "user@example.com",
    "name" => "John",
    "login" => "test_user"
  }

  setup do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = {
      "uid" => '12345',
      "provider" => 'github',
      "credentials" => {"token" => 'my-token'},
      "extra" => {"raw_info" => GITHUB_INFO},
      "info" => GITHUB_INFO,
    }
    OmniAuth.config.add_camelization 'github', 'GitHub'
    if OmniAuth.config.respond_to?(:request_validation_phase)
      OmniAuth.config.request_validation_phase = ->(env) {}
    end

  end

  teardown do
    OmniAuth.config.camelizations.delete('github')
    OmniAuth.config.test_mode = false
  end

  def stub_members!(members)
    OmbuLabs::Auth::CallbacksController.class_eval <<-METHODS, __FILE__, __LINE__ + 1
      alias_method :__old_organization_members, :organization_members

      def organization_members
        #{members}
      end
    METHODS
    yield
  ensure
    OmbuLabs::Auth::CallbacksController.class_eval do
      alias_method :organization_members, :__old_organization_members
    end
  end

  test "allows signing in to users from the github organization" do
    stub_members!([{"login" => 'test_user'}]) do
      assert_equal 0, User.count
      post "/users/auth/github"
      follow_redirect!
      assert_equal 1, User.count

      user = User.first

      assert_equal "github", user.provider
      assert_equal "John", user.name
      assert_equal "user@example.com", user.email
    end
  end

  test "prevents signing in to users outside of the github organization" do
    stub_members!([{"login" => 'not_test_user'}]) do
      assert_equal 0, User.count
      post "/users/auth/github"
      follow_redirect!
      assert_equal 0, User.count

      assert_equal "This application is only available to members of my_org.", flash[:error]
    end
  end
end
