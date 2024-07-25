class ReactionsController < ApplicationController
  before_action :set_likeable
  before_action :authenticate_user!

  include ApplicationHelper

  def create
    @reaction = @likeable.reactions.find_or_initialize_by(liker: current_user)
    
    if @reaction.persisted? && @reaction.reaction_type == reaction_params[:reaction_type]
      @reaction.destroy
    else
      @reaction.reaction_type = reaction_params[:reaction_type]
      @reaction.save
    end
    
    respond_to do |format|
      format.turbo_stream{ flash.now[:notice] = "Reactions updated !" }
      format.html { redirect_to @reaction.likeable , notice: "New Reaction." }
    end
  end

  private

  def set_likeable
    @likeable = if params[:comment_id]
                  Comment.find(params[:comment_id])
                else
                  Article.find(params[:article_id])
                end
  end

  def reaction_params
    params.require(:reaction).permit(:reaction_type)
  end
end
