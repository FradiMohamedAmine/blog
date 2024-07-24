class Reaction < ApplicationRecord
  belongs_to :liker, class_name: 'User'
  belongs_to :likeable, polymorphic: true

  validates :reaction_type, inclusion: { in: %w[like dislike] }

  include ApplicationHelper

  after_create_commit { broadcast_reaction }
  after_update_commit { broadcast_reaction }
  after_destroy_commit { broadcast_reaction }

  private

  def broadcast_reaction
    Turbo::StreamsChannel.broadcast_replace_later_to(
      "reactions_#{nested_dom_id(likeable)}",
      target: "reactions_#{nested_dom_id(likeable)}",
      partial: 'reactions/reaction',
      locals: { likeable: likeable }
    )
  end



 # broadcasts_to ->(reaction) { [reaction.likeable, "reactions"] }, inserts_by: :prepend

end
