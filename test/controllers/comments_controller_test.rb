# frozen_string_literal: true

require 'test_helper'

class CommentControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include ActionView::RecordIdentifier
  include ApplicationHelper

  test 'add comment to post' do
    user = users(:one)
    post = posts(:one)
    comment_content = Faker::Lorem.sentence
    sign_in user
    post post_comments_path(post), params: {
      post_comment: {
        content: comment_content
      }
    }
    comment = PostComment.roots.where(post_id: post.id).find_by(user: user, content: comment_content)
    assert comment
    assert_redirected_to post_path(post, anchor: dom_id(comment))
  end

  test 'add comment to comment' do
    user = users(:two)
    commented = post_comments(:one)
    comment_content = Faker::Lorem.sentence
    sign_in user
    post post_comments_path(commented.post, comment_id: commented.id), params: {
      post_comment: {
        content: comment_content
      }
    }
    comment = PostComment.children_of(commented).find_by(user: user, content: comment_content, post: commented.post)
    assert comment
    assert_redirected_to post_path(commented.post, anchor: dom_id(comment))
  end

  test 'add invalid comment to post' do
    user = users(:one)
    post = posts(:two)
    comment_content = '  '
    sign_in user
    post post_comments_path(post), params: {
      post_comment: {
        content: comment_content
      }
    }
    comment = PostComment.roots.where(post_id: post.id).find_by(user: user, content: comment_content)
    assert_not comment
    assert_redirected_to post_path(post)
  end
end
