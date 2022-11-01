require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  test "login using oauth" do
    visit root_path
    
    click_button 'Sign in with Developer'

    fill_in "Email", with: "some@email.com"
    fill_in "Name", with: "some_user"

    click_button "Sign In"

    assert_selector "h1", text: "All users"
    assert_selector "li", text: "some@email.com"
  end
end