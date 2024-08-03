class CommentSerializer < ActiveModel::Serializer
  attributes :id, :commenter, :body


  belongs_to :article
  has_many :reactions
  has_many :likers, through: :reactions
end
