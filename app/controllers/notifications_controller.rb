class NotificationsController < ApplicationController
  before_action :set_user,only:[:index]
  def index
    @notifications1 =@user.notifications
    render json: @notifications1
  end
private
  def set_user
    @user=User.find(params[:user_id])
  end
end
