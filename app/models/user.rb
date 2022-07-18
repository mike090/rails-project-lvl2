# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable,
         :recoverable # , :validatable

  has_many :posts, foreign_key: 'creator_id', dependent: :destroy, inverse_of: :creator
  has_many :comments, foreign_key: 'creator_id', dependent: :destroy, inverse_of: :user
  has_many :likes, dependent: :destroy, inverse_of: :user

  validates :email, presence: true
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
end
