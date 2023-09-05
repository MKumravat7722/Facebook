class PostSerializer < ActiveModel::Serializer
  attributes :id ,:caption ,:images 
  has_many :likes 
  has_many :comments
  
  def images
    object.images.map do |data|
      data.url
    end
  end
end
