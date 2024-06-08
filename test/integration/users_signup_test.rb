require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {user: {name: "",
                              email: "aa@gg.jp",
                              password: "foo",
                              password_confirmation: "bar"}}
    end
    assert_response :unprocessable_entity
    assert_template 'users/new'
  end

  test "valid signup information" do
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "Example User",
                              email: "user@example.com",
                              password: "password",
                              password_confirm: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert logged_in?
  end
end
