# frozen_string_literal: true

class Post < ApplicationRecord
  include Creatorable

  belongs_to :category
  has_many :comments, class_name: 'PostComment', dependent: :destroy, inverse_of: :post
  has_many :likes, class_name: 'PostLike', dependent: :destroy, inverse_of: :post

  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 5 }

  scope :by_recently_created, -> { order(id: :desc) }
  scope :by_earliest_created, -> { order(id: :asc) }
end
