class CommentsController < ApplicationController

  before_action :authorize_action, only: [:edit, :delete]

  def create
    @note = Note.find(params[:note_id])
    @comment = @note.comments.create(comment_params)
    @comment.user_id = current_user.id 
    if @comment.save
      redirect_to note_path(@note)
    else
      flash[:alert] = "Comment creation failed !!!!"
      render :new
    end  
  end

  def edit
  end  

  def update
    @comment = Comment.find_by(id: params[:id])
    if @comment.update(comment_params)
      flash[:notice] = "Comment successfully updated !!"
      redirect_to note_path(@comment.note)
    else
      flash[:alert] = "Comment update failed !!"
      render :edit
    end   
  end

  def destroy
      @comment = Comment.find(params[:id])
    if @comment.present?
       @comment.destroy
    end
    redirect_to note_path(@comment.note)
  end  

  private

  def authorize_action
    @comment = Comment.find_by(id: params[:id])
    unless @comment.user_id == current_user.id 
      flash[:alert] = 'Unauthorize Access'
      redirect_to notes_path
    end 
  end

  def comment_params
    params.require(:comment).permit(:body, :name, :user_id)
  end

end
