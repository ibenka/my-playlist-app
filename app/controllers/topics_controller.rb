class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
    authorize! :create, @topic, message: "You need to be an admin to do that."
  end

  def show
    @topic = Topic.find(params[:id])
    @posts = @topic.posts
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

  private

  def topic_params
    params.require(:topic).permit(:name, :public, :description, 
                                  posts_attributes: [:title, :body, 
                                  comments_attributes: [:body]])
  end
end
