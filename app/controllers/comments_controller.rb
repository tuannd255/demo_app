class CommentsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @comment = current_user.comments.build(comment_params)
    @entry = Entry.find(@comment.entry_id)
    if @comment.save
      # flash[:success] = "comment created!"
      redirect_to request.referrer
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @comment.destroy
    # flash[:success] = "comment deleted"
    redirect_to request.referrer || root_url
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :entry_id)
    end
    
    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end
end
