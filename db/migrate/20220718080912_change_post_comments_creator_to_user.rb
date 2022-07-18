# frozen_string_literal: true

class ChangePostCommentsCreatorToUser < ActiveRecord::Migration[6.1]
  def change
    rename_column :post_comments, :creator_id, :user_id
  end
end
