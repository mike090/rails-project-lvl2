# frozen_string_literal: true

class PostComment < ApplicationRecord
  include Creatorable

  belongs_to :post
  has_ancestry

  validates :content, presence: true, length: { minimum: 5 }

  scope :on_the_post, ->(post) { roots.where(post_id: post.id) }
  scope :by_recently_created, -> { order(id: :desc) }
  scope :by_earliest_created, -> { order(id: :asc) }
end
