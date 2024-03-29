class Topics::PostsController < ApplicationController
  def show
    @topic = Topic.find(params[:topic_id])
    authorize! :read, @topic, message: "You need to be signed-in to do that."
    @post = Post.find(params[:id])
    @playlists = @post.playlists
    @song = Playlist.new
    @comment = Comment.new

    @client = soundcloud_client
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
    @post.topic = @topic
    #We are assigning the topic to the post during the create method. 
    #This means that we don't have to pass it in through the form.
    authorize! :create, @post, message: "You need to be signed up to do that."
    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
    else
      flash[:notice] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    title = @post.title
    authorize! :destroy, @post, message: "You need to own the post to delete it."
    if @post.destroy
      flash[:notice] = "\"#{title}\" was deleted successfully."
      redirect_to @topic
    else
      flash[:error] = "There was an error deleting the post."
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image, 
      user_attributes: [:avatar], 
      comments_attributes: [:body],
      votes_attributes: [:value, :post_id])
  end

  def soundcloud_client
    #if not, create a soundcloud client from the User's method
    #since it doesn't matter what specific user, just using the 
    #User model
    @soundcloud_client = User.soundcloud_client()
  end
end
