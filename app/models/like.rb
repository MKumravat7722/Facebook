require 'byebug'
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post 
  validate :unique_like_for_user, on: :create
  has_many :notifications , as: :notifiable, dependent: :destroy
  after_create :create_like_notification
  
  def unique_like_for_user
    if Like.exists?(user_id: user_id, post_id: post_id)
      errors.add(:base, "User can like a post only once")
    end
  end
  
  def self.unlike(user_id, post_id)
    like = Like.find_by(user_id: user_id, post_id: post_id)
    like.destroy if like
  end
  
  def create_like_notification
    Notification.create(
    # byebug
    user: post.user,
    notifiable: self,
    notifiable_id: id,
    notifiable_type: 'Like',
    message: "#{user.username} liked your post: #{post.image}"
   )
  end
  
end
