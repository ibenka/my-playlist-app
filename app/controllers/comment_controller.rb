class CommentController < ApplicationController
  def create
    Comment.create(comment_params)
  end

  def post_params
    params.require(:comment).permit(:body)
  end
end