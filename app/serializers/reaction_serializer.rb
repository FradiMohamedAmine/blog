class ReactionSerializer < ActiveModel::Serializer
  attributes :id, :reaction_type

  belongs_to :liker, serializer: UserSerializer
  belongs_to :likeable, polymorphic: true
end
