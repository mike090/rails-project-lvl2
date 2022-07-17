# frozen_string_literal: true

class CreatePostLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :post_likes do |t|
      t.belongs_to :user
      t.belongs_to :post

      t.timestamps

      t.index %i[post_id user_id], unique: true
    end
  end
end
