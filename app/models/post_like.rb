# frozen_string_literal: true

class PostLike < ApplicationRecord
  belongs_to :post, counter_cache: :count_of_likes
  belongs_to :user

  scope :by_user_and_post, ->(user, post) { where post: post, user: user }
end
