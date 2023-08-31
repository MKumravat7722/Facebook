class User < ApplicationRecord
   has_secure_password
   has_one_attached :profile_picture
   has_many :posts, -> { order(created_at: :desc) }, dependent: :destroy
   has_many :comments, dependent: :destroy
   has_many :likes, dependent: :destroy  
   has_many :notifications , dependent: :destroy
 
   has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow', dependent: :destroy
   has_many :followees, through: :followed_users,dependent: :destroy
   has_many :following_users, foreign_key: :followee_id, class_name: 'Follow', dependent: :destroy
   has_many :followers ,through: :following_users,dependent: :destroy 
 
   validates :first_name, presence: true
   validates :last_name, presence: true
   validates :email, presence: true, uniqueness: true
   validates :username, presence: true, uniqueness: true
   validate  :validate_email
   def validate_email
      if (email =~ /^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$/).nil?
        errors.add(:email, 'please enter a valid email')
      end
   end
end