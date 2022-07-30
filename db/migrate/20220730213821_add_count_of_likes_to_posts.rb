# frozen_string_literal: true

class AddCountOfLikesToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :count_of_likes, :integer
  end
end
