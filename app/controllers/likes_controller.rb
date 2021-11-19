class LikesController < ApplicationController

	before_action :authenticate_user!
  before_action :find_note
	before_action :find_like, only: [:destroy]

  def create 
    @like = @note.likes.create(note_id: params[:note_id], user_id: current_user.id)
	end
  
	def destroy
		@like.destroy
	end

	def find_like
    @like = @note.likes.find(params[:id])
	end

	private
  def find_note
    @note = Note.find(params[:note_id])
  end

end
