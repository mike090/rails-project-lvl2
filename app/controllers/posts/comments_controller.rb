# frozen_string_literal: true

module Posts
  class CommentsController < ApplicationController
    def create
      authenticate_user!
      @post = Post.find params[:post_id]
      @parent_comment = PostComment.find_by id: params[:comment_id]

      @new_comment = @post.comments.build(comment_params)
      @new_comment.user = current_user
      @new_comment.parent = @parent_comment

      if @new_comment.save
        redirect_to post_path(@post, anchor: dom_id(@new_comment)), success: t('.success')
      else
        redirect_to @post, warning: @new_comment.errors.full_messages.join(' ')
      end
    end

    private

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:post_comment).permit(:content)
    end
  end
end
