require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: 'john',
                        email: 'john@example.com',
                        password: 'password',
                        admin: true)
  end

  def test_get_new_category_form_and_create_category
    sign_in_as(@user, @user.password)
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      post_via_redirect categories_path, category: { name: 'sports' }
    end
    assert_template 'categories/index'
    assert_match 'sports', response.body
  end

  def test_invalid_category_submission_results_in_failure
    sign_in_as(@user, @user.password)
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, category: { name: ' ' }
    end
    # the error partial shows up
    assert_template 'categories/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end
