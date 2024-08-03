module Api
  class ReactionsController < ApplicationController
    protect_from_forgery with: :null_session
    before_action :set_likeable
    skip_before_action :authenticate_user!, only: [:create]

    # POST /api/articles/:article_id/reactions
    # POST /api/comments/:comment_id/reactions
    def create
      user = User.find(params[:user_id]) # Use user_id parameter for testing
      @reaction = @likeable.reactions.find_or_initialize_by(liker: user)

      if @reaction.persisted? && @reaction.reaction_type == reaction_params[:reaction_type]
        @reaction.destroy
        head :no_content
      else
        @reaction.reaction_type = reaction_params[:reaction_type]
        if @reaction.save
          render json: @reaction, status: :created, serializer: ReactionSerializer
        else
          render json: @reaction.errors, status: :unprocessable_entity
        end
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
end
