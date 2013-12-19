class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
  end

  def edit
  end

  def create
    Post.create(post_params)
  end
  
  private

  def post_params
    params.require(:post).permit(:title, :body, comments_attributes: [:body])
  end
end
