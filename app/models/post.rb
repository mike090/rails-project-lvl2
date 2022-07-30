# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :category
  has_many :comments, class_name: 'PostComment', dependent: :destroy
  has_many :likes, class_name: 'PostLike', dependent: :destroy

  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 5 }

  scope :by_recently_created, -> { order(id: :desc) }
end
