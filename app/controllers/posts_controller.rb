class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
    @topic = Topic.find(params[:topic_id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    authorize! :create, @post, message: "You need to be a member to create a new post."
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize! :edit, @post, message: "You need to own the post to edit it."
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    @post.topic = @topic
    #We are assigning the topic to the post during the create method. 
    #This means that we don't have to pass it in through the form.
    authorize! :update, @post, message: "You need to own the post to edit it."
    if @post.update_attributes(post_params)
      flash[:notice] = "Post was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def create
    @topic = Topic.find(params[:topic_id])
    #@post = current_user.posts.build(params[:post])
    @post = current_user.posts.build(post_params)
    authorize! :create, @post, message: "You need to be signed up to do that."
    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to @post
    else
      flash[:notice] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, comments_attributes: [:body])
  end
end
