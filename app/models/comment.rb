class Comment < ApplicationRecord
  belongs_to :article

  has_many :reactions, as: :likeable
  has_many :likers, through: :reactions, source: :liker


  scope :ordered, -> { order(id: :desc) }

  after_create_commit -> { broadcast_prepend_later_to "comments" }
  after_update_commit -> { broadcast_replace_later_to "comments", target: "comment_#{self.id}" }


end
