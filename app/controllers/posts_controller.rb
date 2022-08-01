# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.by_recently_created.includes :creator
  end

  def new
    authenticate_user!
    @post = current_user.posts.new
  end

  def create
    authenticate_user!
    @post = current_user.posts.new post_params
    if @post.save
      redirect_to root_path, success: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    set_post!
    set_like # only for hexlet check
    set_comment_template
    set_post_comments
    @post = @post.decorate
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end

  def set_post!
    @post = Post.find params[:id]
  end

  def set_comment_template
    @comment_template = @post.comments.build
  end

  def set_post_comments
    @comments = PostComment.includes(:user).arrange post: @post, order: :created_at
  end

  # only for hexlet check
  def set_like
    @like = PostLike.by_user_and_post(current_user, @post)
  end
end
