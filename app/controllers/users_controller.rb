class UsersController < ApplicationController
  skip_before_action :authenticate_user,only: :create
  def index
    render json: @current_user
  end
  
  def show
    follower_ids = @current_user.followers.pluck(:follower_id)
    followee_ids = @current_user.followees.pluck(:followee_id)
    post_user_ids = (follower_ids + followee_ids + [@current_user.id]).uniq
    @posts = Post.where(user_id: post_user_ids)
    render json: @posts
  end
  
  def new
    @user=User.new
  end
  
  def create
    @user =User.new(user_params)
    if @user.save
      UserMailer.with(user: @user).welcome_email.deliver_now
      render json: @user, status: 201
    else
      render json: {error: @user.errors.full_messages}, status: 400
    end
  end
  
  def update
    if @current_user.update(user_params)
      render json: @current_user,status: 200
    else
      render json: {error: @current_user.errors.full_messages},status: 404
    end
  end
  
  def destroy
    @current_user.destroy
    render json:'User Deleted Succesfully..'
  end
  # def follow
  #   @user = User.find(params[:id])
  #   current_user.followees << @user
  #   render 
  # end
  # def unfollow
  #   @user = User.find(params[:id])
  #   current_user.followed_users.find_by(followee_id: @user.id).destroy
  #   redirect_back(fallback_location: user_path(@user))
  # end
  def follow
    user = User.find(params[:id])
    current_user.followees << user
    render json: user
  end
  
  def unfollow
    user = User.find(params[:id])
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    render json: user
  end
  
  
  
  private def user_params 
    params.permit(
      :first_name,
      :last_name,
      :username,
      :email,
      :password,
      :profile_picture
    )
  end
end



