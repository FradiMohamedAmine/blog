class ReactionsController < ApplicationController
    before_action :find_likeable
    before_action :find_reaction, only: [:destroy]
  
    def create
      @reaction = @likeable.reactions.build(reaction_params)
      @reaction.liker = current_user
  
      if @reaction.save
        respond_to do |format|
          format.html { redirect_to @likeable, notice: 'Reaction was successfully created.' }
          format.turbo_stream
        end
      else
        respond_to do |format|
          format.html { redirect_to @likeable, alert: 'Unable to create reaction.' }
          format.turbo_stream
        end
      end
    end
  
    def destroy
      @reaction.destroy
      respond_to do |format|
        format.html { redirect_to @likeable, notice: 'Reaction was successfully removed.' }
        format.turbo_stream
      end
    end
  
    private
  
    def find_likeable
      @likeable = if params[:article_id]
                    Article.find(params[:article_id])
                  else
                    Comment.find(params[:comment_id])
                  end
    end
  
    def find_reaction
      @reaction = @likeable.reactions.find(params[:id])
    end
  
    def reaction_params
      params.require(:reaction).permit(:reaction_type)
    end
end