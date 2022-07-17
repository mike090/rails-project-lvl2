# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ActionView::RecordIdentifier

  def focus_comment_path(comment)
    post_path(comment.post, anchor: dom_id(comment))
  end
end
