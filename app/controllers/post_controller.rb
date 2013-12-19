class PostController < ApplicationController
  def create
    Post.create(post_params)
  end

  private
  
  def post_params
    params.require(:post).permit(:title, :body, comments_attributes: [:body])
  end
end