class Reaction < ApplicationRecord
  belongs_to :liker, class_name: 'User'
  belongs_to :likeable, polymorphic: true

  validates :reaction_type, inclusion: { in: %w[like dislike] }
end
