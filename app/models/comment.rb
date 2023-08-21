class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :parent_comment,class_name:'Comment',optional: true
  has_many :replies,class_name: 'Comment',foreign_key: 'parent_comment_id', dependent: :destroy
  has_many :notifications , as: :notifiable, dependent: :destroy
  after_create :create_comment_notification
  validates :content, presence: true
  validates :content, :user_id ,:post_id ,presence: true
  
  private
  
  def create_comment_notification
    Notification.create(
      user: post.user,
      notifiable: self,
      notifiable_id: id,
      notifiable_type: 'Comment',
      message: "#{user.username} Commented on your post: #{post.caption}" 
    )
     
  end
 
end