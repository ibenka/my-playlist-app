class PlaylistsController < ApplicationController
  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @playlist = Playlist.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    #@post = current_user.posts.build(params[:post])
    @post = Post.find(params[:post_id])
    @playlist = current_user.playlists.build(playlist_params)
    @playlist.topic = @topic
    @playlist.post = @post
    @playlist.order = @post.playlists.count + 1
    #We are assigning the topic to the post during the create method. 
    #This means that we don't have to pass it in through the form.
    #authorize! :create, @post, message: "You need to be signed up to do that."
    if @playlist.save
      flash[:notice] = "Playlist was saved."
      redirect_to [@topic, @post]
    else
      flash[:notice] = "There was an error saving the playlist. Please try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    @playlist = Playlist.find(params[:id])
    #authorize! :edit, @post, message: "You need to own the post to edit it."
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    @playlist = Playlist.find(params[:id])
    #authorize! :update, @post, message: "You need to own the post to edit it."
    if @playlist.update_attributes(playlist_params)
      flash[:notice] = "Playlist was updated."
      redirect_to [@topic, @playlist.post]
    else
      flash[:error] = "There was an error saving the playlist. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    @playlist = Playlist.find(params[:id])
    #authorize! :destroy, @post, message: "You need to own the post to delete it."
    if @post.destroy
      flash[:notice] = "The song was deleted successfully."
      redirect_to [@topic, @playlist.post]
    else
      flash[:error] = "There was an error deleting the song."
      render :show
    end
  end

  def playlist_params
    params.require(:playlist).permit(:url, :order, :topic_id, :post_id,
      post_attributes: [:title, :body, :image],
      topic_attributes: [:name, :public, :description], 
      user_attributes: [:avatar], 
      comments_attributes: [:body],
      votes_attributes: [:value, :post_id])
  end
end