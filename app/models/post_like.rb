# frozen_string_literal: true

class PostLike < ApplicationRecord
  belongs_to :post
  belongs_to :user

  scope :user_like_post, ->(user, post) { where post: post, user: user }
end
