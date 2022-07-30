# frozen_string_literal: true

class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: :count_of_comments
  has_ancestry

  validates :content, presence: true, length: { minimum: 5 }

  scope :roots_for_post, ->(post) { roots.where(post_id: post.id) }
  # scope :by_recently_created, -> { order(id: :desc) }
  scope :by_earliest_created, -> { order(id: :asc) }
end
