require 'test_helper'

class CreateArticlesTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: 'john',
                        email: 'john@example.com',
                        password: 'password',
                        admin: false)
  end

  def test_create_article_success
    sign_in_as(@user, @user.password)
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post_via_redirect articles_path, article: { title: 'the test article', description: 'the test description of test article' }
    end
    assert_template 'articles/show'
  end

  def test_create_article_fail_with_title_or_description_too_short
    sign_in_as(@user, @user.password)
    get new_article_path
    assert_template 'articles/new'
    assert_no_difference 'Article.count' do
      post articles_path, article: { title: 'the test article', description: 'the' }
    end
    # the error partial shows up
    assert_template 'articles/new'
    assert_match 'Description is too short', response.body
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'

    get new_article_path
    assert_template 'articles/new'
    assert_no_difference 'Article.count' do
      post articles_path, article: { title: 't', description: 'the test description of test article' }
    end
    # the error partial shows up
    assert_template 'articles/new'
    assert_match 'Title is too short', response.body
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end
