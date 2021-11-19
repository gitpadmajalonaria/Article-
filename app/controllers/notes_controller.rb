class NotesController < ApplicationController

  before_action :authenticate_user!, except: [:index]
  before_action :set_note
  before_action :authorize_action, except: [:index, :new, :create, :show]

  def new
    @note = Note.new
  end

  def index
    @notes = Note.all
  end

  def edit
  end 

  def show  
  end

  def create
    @note = current_user.notes.new(notes_params)
    if @note.save
      redirect_to note_path(@note)
    else
      flash[:alert] = "Note creation failed !!!!"
      render :new
    end
  end

  def update
    if @note.update(notes_params)
      flash[:notice] = "Note successfully updated !!"
      redirect_to note_path(@note)
    else
      flash[:alert] = "Note update failed !!"
      render :edit
    end   
  end

  def destroy
    @note.destroy
  end

  private

  def authorize_action
    unless @note.user_id == current_user.id
      flash[:alert] = 'Unauthorize Access'
      redirect_to notes_path
    end 
  end

  def set_note
    @note = Note.find_by(id: params[:id])
  end

  def notes_params
    params.require(:note).permit(:title, :description, :image)
  end 

end
