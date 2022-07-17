# frozen_string_literal: true

class PostDecorator < ApplicationDecorator
  delegate_all

  def published_date_long
    l created_at.to_date, format: :long
  end

  def published_date
    l created_at.to_date, format: :default
  end

  def liked_by?(user)
    PostLike.user_like_post(user, self).any?
  end
end
