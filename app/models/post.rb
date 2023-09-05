class Post < ApplicationRecord
  belongs_to :user 
  has_many :comments, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many_attached :photos
  validates :caption, presence: true
end
