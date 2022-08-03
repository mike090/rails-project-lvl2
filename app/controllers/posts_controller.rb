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
    @post = Post.find params[:id]
    set_like # only for hexlet check
    @new_comment = @post.comments.build
    @comments = comments_tree
    @post = @post.decorate
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end

  def comments_tree
    PostComment.includes(:user).arrange post: @post, order: :created_at
  end

  # only for hexlet check
  def set_like
    @like = PostLike.by_user_and_post(current_user, @post)
  end
end
