# frozen_string_literal: true

class ChangePostCommentsPostNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :post_comments, :post_id, false
  end
end
