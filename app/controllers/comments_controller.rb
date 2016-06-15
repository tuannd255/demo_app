class CommentsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @comment = current_user.comments.build(comment_params)
    @entry = Entry.find(@comment.entry_id)
    
    if !current_user.following?(@entry.user) && !current_user?(@entry.user)
      flash[:danger] = "Can not comment if you unfollow"
      respond_to do |format|
        format.html {  redirect_to request.referrer }
        format.js
      end
    elsif @comment.content.length > 140
      flash[:danger] = "Comment is long"
      respond_to do |format|
        format.html {  redirect_to request.referrer }
        format.js
      end
    elsif @comment.save
      respond_to do |format|
        format.html {  redirect_to request.referrer }
        format.js
      end
    else
      flash[:danger] = "Can not comment blank"
      redirect_to request.referrer
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @entry = Entry.find(@comment.entry_id)
    @comment.destroy
    respond_to do |format|
        format.html {  redirect_to request.referrer || root_url }
        format.js
      end
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
