class LikesController < ApplicationController
  before_action :set_post ,only:[:create,:destroy,:show]  
  def index
    @likes=Like.all
    render json: @likes
  end
  def show 
    if @post
      render json @post.likes
    else
      render json: {message:"invalid input"}
    end
  end   
  def create
    @likes=@post.likes.new(like_params)
    if @likes.save
      render json: {message:"likes created succesfully"}
    else
      render json: {error: "like not created"}
    end
  end 
  private def like_params 
    params.require(:like).permit( 
      :user_id,
    )
  end
  def destroy
    @like=@post.likes.find(params[:id])
    if @like 
      @like.destroy
      render json: @like
      # render json: {message: "Post Unlike  succesfull"}
    else
      render json: {message: "likes not exists in this post"}
    end
    # redirect_to post_path(@post)
  end
  def set_post
    @post=Post.find(params[:post_id])
  end
end
