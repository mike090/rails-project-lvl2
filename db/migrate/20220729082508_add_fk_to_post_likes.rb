# frozen_string_literal: true

class AddFkToPostLikes < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :post_likes, :users
    add_foreign_key :post_likes, :posts
  end
end
