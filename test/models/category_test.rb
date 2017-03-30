require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = Category.new(name: 'sport')
  end

  def test_category_should_be_valid
    assert @category.valid?
  end

  def test_name_should_be_present
    @category.name =' '
    assert_not @category.valid?
  end

  def test_name_should_be_unique
    @category.save
    another_category = Category.new(name: 'sport')
    assert_not another_category.valid?
  end

  def test_name_should_not_be_too_long
    @category.name = 'a' * 26
    assert_not @category.valid?
  end

  def test_name_should_not_be_too_short
    @category.name = 'a' * 2
    assert_not @category.valid?
  end
end