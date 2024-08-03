class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :body

  has_many :comments
  has_many :reactions
  has_many :likers, through: :reactions  
end
