# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'authented user can like' do
    post = posts :one
    user = users :one
    sign_in user
    post post_like_path(post)
    assert_redirected_to post_path(post)
    assert PostLike.find_by(user: user, post: post)
  end

  test 'duble like not raises' do
    post = posts :one
    user = users :one
    sign_in user
    post post_like_path(post)
    assert_nothing_raised { post post_like_path(post) }
    assert PostLike.find_by(user: user, post: post)
  end

  test 'not authented user redirected when like' do
    post = posts :one
    user = users :one
    sign_out users(:one)
    assert_not PostLike.find_by(user: user, post: post)
    post post_like_path(post)
    assert_redirected_to new_user_session_path
    assert_not PostLike.find_by(user: user, post: post)
  end

  test 'authented user can unlike' do
    post = posts :two
    user = users :one
    sign_in users(:one)
    assert PostLike.find_by(user: user, post: post)
    delete post_like_path(post)
    assert_redirected_to post_path(post)
    assert_not PostLike.find_by(user: user, post: post)
  end

  test 'not authented user redirected when unlike' do
    post = posts :two
    user = users :one
    sign_out users(:one)
    assert PostLike.find_by(user: user, post: post)
    delete post_like_path(post)
    assert_redirected_to new_user_session_path
    assert PostLike.find_by(user: user, post: post)
  end
end
