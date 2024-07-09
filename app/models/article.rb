class Article < ApplicationRecord
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
  scope :ordered, -> { order(id: :desc) }

  after_create_commit -> { broadcast_prepend_later_to "articles" }
  after_update_commit -> { broadcast_replace_later_to "articles" }
  after_destroy_commit ->(article) { broadcast_remove_to "articles" }

  # broadcasts_to ->(article) { "articles" }, inserts_by: :prepend
end
