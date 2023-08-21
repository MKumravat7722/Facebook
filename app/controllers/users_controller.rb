class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: :create
  before_action :set_user,only:[:show,:update,:destroy]
  def index
    @users=User.all 
    render json: @users
    # redirect_to "/user/#{11}/notifications"
    # redirect_to "/posts/#{user_id}"
    # /user/:user_id/notifications
  end
  def show
    if @user
     render json: @user
    else  
      render json: {error: 'Unable to Show User Or Id not found'},status: 400    
    end
  end
  def new
     @user=User.new
  end
  def user_post
    @user=User.find(params[:id])
    follower_ids = @user.followers.pluck(:follower_id)
    followee_ids = @user.followees.pluck(:followee_id)
    post_user_ids = (follower_ids + followee_ids + [@user.id]).uniq
    @posts = Post.where(user_id: post_user_ids)
    render json: @posts
  end
  def create
    
    @user =User.new(user_params)
    if @user.save 
       render json: @user, status: 201
    else
      render json: {error: @user.errors.full_messages}   
    end
  end

  def update
    if @user.update(user_params)
        #redirect_to(@user)
        render json: @user,status: 200
    else
      render json: {error: 'User Not Found'},status: 404  
    end
  end
  def destroy
    @user.destroy
    render json:'User Deleted Succesfully..'
  end
  def follow
    @user = User.find(params[:id])
    current_user.followees << @user
    render 
  end
  def unfollow
    @user = User.find(params[:id])
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    redirect_back(fallback_location: user_path(@user))
  end
  private def set_user
    @user=User.find(params[:id])
  end
  private def user_params 
    params.permit(
      :first_name,
      :last_name,
      :username,
      :email,
      :password_digest,
      :profile_picture
    )
  end
end



