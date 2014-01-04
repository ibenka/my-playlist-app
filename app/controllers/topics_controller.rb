class TopicsController < ApplicationController
  def index
    #@topics = Topic.all
    @topics = Topic.paginate(page: params[:page], per_page: 10)
  end

  def new
    @topic = Topic.new
    authorize! :create, @topic, message: "You need to be an admin to do that."
  end

  def show
    @topic = Topic.find(params[:id])
    #@posts = @topic.posts
    @posts = @topic.posts.paginate(page: params[:page], per_page: 10)
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize! :update, @topic, message: "You need to be an admin to do that."
  end

  def update
    @topic = Topic.find(params[:id])
    authorize! :update, @topic, message: "You need to own the topic to update it."
    if @topic.update_attributes(topic_params)
      redirect_to @topic, notice: "Topic was saved successfully."
    else
      flash[:error] = "There was an error saving the topic. Please try again."
      render :edit
    end
  end

  def create
    #@topic = current_user.posts.build(params[:topic])
    @topic = Topic.new(topic_params)
    authorize! :create, @topic, message: "you need to be an admin to do that."
    if @topic.save
      redirect_to @topic, notice: "Topic was saved successfully."
    else
      flash[:notice] = "There was an error saving the topic. Please try again."
      render :new
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    name = @topic.name
    authorize! :destroy, @topic, message: "You need to own the topic to delete it."
    if @topic.destroy
      flash[:notice] = "\"#{name}\" was deleted successfully."
      redirect_to topics_path
    else
      flash[:error] = "There was an error deleting the topic."
      render :show
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:name, :public, :description, 
                                  posts_attributes: [:title, :body, 
                                  comments_attributes: [:body], 
                                  votes_attributes: [:value, :post_id]])
  end
end
