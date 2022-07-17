# frozen_string_literal: true

module ApplicationHelper
  def create_comment_path(post, commented = nil)
    post_comments_path(post, comment: commented&.id)
  end
end
