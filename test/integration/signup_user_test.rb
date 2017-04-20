require 'test_helper'

class SignupUserTest < ActionDispatch::IntegrationTest
  def setup
    User.create(username: 'john',
                email: 'john@example.com',
                password: 'password',
                admin: false)
  end

  def test_signup_user_success
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { username: 'chris shao', email: 'chris@gmail.com', password: 'test' }
    end
    assert_template 'users/show'
    assert_match 'Welcome to Cycle around Taiwan! chris shao', response.body
  end

  def test_signup_user_fail
    get signup_path
    assert_template 'users/new'
    assert_no_difference 'User.count' do
      post users_path, user: { username: 'a', email: 'a@gmail.com', password: 'test' }
    end
    # the error partial shows up
    assert_template 'users/new'
    assert_match 'Username is too short', response.body
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'

    get signup_path
    assert_template 'users/new'
    assert_no_difference 'User.count' do
      post users_path, user: { username: 'john', email: 'john@example.com', password: 'test' }
    end
    # the error partial shows up
    assert_template 'users/new'
    assert_match 'Username has already been taken', response.body
    assert_match 'Email has already been taken', response.body
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'

    get signup_path
    assert_template 'users/new'
    assert_no_difference 'User.count' do
      post users_path, user: { username: 'amy', email: 'amy@example.com', password: '' }
    end
    # the error partial shows up
    assert_template 'users/new'
    assert_match 'Password can&#39;t be blank', response.body
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end
