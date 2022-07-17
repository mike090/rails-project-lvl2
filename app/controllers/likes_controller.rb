# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    authenticate_user!
    set_post!
    PostLike.create! user: current_user, post: @post unless PostLike.user_like_post(current_user, @post).any?

    redirect_to @post
  end

  def destroy
    authenticate_user!
    set_post!
    PostLike.user_like_post(current_user, @post).delete_all
    redirect_to @post
  end

  private

  def set_post!
    @post = Post.find params[:post_id]
  end
end
