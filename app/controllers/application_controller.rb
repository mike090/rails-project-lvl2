# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ActionView::RecordIdentifier

  add_flash_types :success, :warning, :danger, :info

  def focus_comment_path(comment)
    post_path(comment.post, anchor: dom_id(comment))
  end
end
