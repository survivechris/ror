require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  def setup
    @category = Category.create(name: 'sport')
    @user = User.create(username: "john",
                        email: "john@example.com",
                        password: "password",
                        admin: true)
  end

  def test_should_get_categories_index
    get :index
    assert_response :success
  end

  def test_should_get_new
    session[:user_id] = @user.id
    get :new
    assert_response :success
  end

  def test_should_get_show
    get(:show, { :id => @category.id })
    assert_response :success
  end

  def test_should_redirect_create_when_admin_not_logged_in
    assert_no_difference 'Category.count' do
      post :create, category: { name: 'sports' }
    end
    assert_redirected_to categories_path
  end
end