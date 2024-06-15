require 'test_helper'

class HeaderLinkTest < ActionDispatch::IntegrationTest
    def setup
        @user = users(:michael)
    end
    test "should be displayed at login" do
        log_in_as(@user)
        get root_path
        assert_select "a[href=?]", root_path, count: 2
        assert_select "a[href=?]", help_path, count: 1
        assert_select "a[href=?]", users_path, count: 1
        assert_select "a[href=?]", user_path(@user), count: 3
        assert_select "a[href=?]", edit_user_path(@user), count: 1
        assert_select "a[href=?]", logout_path, count: 1
        assert_select "a[href=?]", login_path, count: 0
    end

    test "should be displayed at logout" do
        get root_path
        assert_select "a[href=?]", root_path, count: 2
        assert_select "a[href=?]", help_path, count: 1
        assert_select "a[href=?]", users_path, count: 0
        assert_select "a[href=?]", edit_user_path(@user), count: 0
        assert_select "a[href=?]", logout_path, count: 0
        assert_select "a[href=?]", login_path, count: 1
    end
end