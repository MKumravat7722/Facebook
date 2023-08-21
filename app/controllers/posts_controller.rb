class PostsController < ApplicationController
  before_action :set_user, only: [:index, :show, :create, :update, :destroy]
  def index
    @posts=Post.all
    render json: @posts
  end
  def show
    @post = @user.posts.includes(:comments, :likes).find(params[:id])
    render json: @post, include: [:comments, :likes]
  end
   def user_post_by_user
    @user = User.find(params[:id])
    @post = @user.posts.includes(:comments, :likes)
    render json: @post, include: [:comments, :likes]
   end
  def create
    @post = @user.posts.new(post_params)
    if @post.save
     render json: @post,status: 200
    else
      render json: { error: "Post not created" }
    end
  end
  def update
    @post = @user.posts.find(params[:id])
    if @post.user == @user && @post.update(post_params)
      render json: @post
    else
      render json: { error: "Unable to update this post" }
    end
  end
  def destroy
    @post = @user.posts.find(params[:id])
    if @post.user == @user
      @post.destroy
      render json:{message: "Post Deleted Succesfull"},status: 200
    else
      render json: { error: "Unable to delete this post" }
    end
  end
  private
  def post_params
    params.require(:post).permit(
      :caption,
      :image,
      :user_id
    )
  end
  def set_user
    @user = User.find(params[:user_id])
  end
end