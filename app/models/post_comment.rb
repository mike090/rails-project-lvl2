# frozen_string_literal: true

class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: :count_of_comments
  has_ancestry

  validates :content, presence: true, length: { minimum: 5 }
end
