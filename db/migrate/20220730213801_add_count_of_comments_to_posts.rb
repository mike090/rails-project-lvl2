# frozen_string_literal: true

class AddCountOfCommentsToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :count_of_comments, :integer
  end
end
