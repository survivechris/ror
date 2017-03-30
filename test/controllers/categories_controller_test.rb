require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  def setup
    @category = Category.create(name: 'sport')
  end

  def test_should_get_categories_index
    get :index
    assert_response :success
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_get_show
    get(:show, { :id => @category.id })
    assert_response :success
  end
end