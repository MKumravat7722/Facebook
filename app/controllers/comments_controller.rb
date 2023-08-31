class CommentsController < ApplicationController
  before_action :set_post ,only:[:create]  
  def index 
    @comments=@post.comments
    render json: @comments
  end
  def show
    render json: @post
  end
  def create
    @comments=@post.comments.new(comments_params)
    if @comments.save
      render json: @post.user ,status: 200
    else
      render json: {error: "Post not created"}
    end
  end
  private def comments_params 
    params.require(:comment).permit( 
      :content,
      :user_id,
      :post_id
    )
  end
  def set_post
    @post=Post.find(params[:post_id])
  end
  
end
