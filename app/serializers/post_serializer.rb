class PostSerializer < ActiveModel::Serializer
  attributes :id ,:caption ,:image 
  has_many :likes 
  has_many :comments
end
