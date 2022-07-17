# frozen_string_literal: true

module Posts
  class CommentsController < ApplicationController
    def create
      authenticate_user!
      set_post!
      set_parent_comment

      @new_comment = @post.comments.build(comment_params)
      @new_comment.creator = current_user
      @new_comment.parent = @parent_comment

      if @new_comment.save
        redirect_to focus_comment_path(@new_comment), notice: t('.success')
      else
        destination = @parent_comment ? focus_comment_path(@parent_comment) : post_path(@post)
        redirect_to destination, notice: @new_comment.errors.full_messages.join(' ')
      end
    end

    private

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:post_comment).permit(:content)
    end

    def set_post!
      @post = Post.find params[:post_id]
    end

    def set_parent_comment
      @parent_comment = PostComment.find_by id: params[:comment]
    end
  end
end
