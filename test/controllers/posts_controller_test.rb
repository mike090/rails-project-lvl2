# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should get index' do
    get posts_url
    assert_response :success
  end

  test 'should show post' do
    get(post_url(posts(:one)))
    assert_response :success
  end

  test 'should create post' do
    sign_in users(:one)
    title = Faker::Lorem.sentence
    post posts_url params: {
      post: {
        user: users(:one),
        title: title,
        body: 'test post body',
        category_id: categories(:one).id
      }
    }
    assert_response :redirect
    assert_not_nil Post.find_by(title: title)
  end

  test 'should get new' do
    sign_in users(:one)
    get new_post_url
    assert_response :success
  end
end
