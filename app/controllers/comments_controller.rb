class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.new(comment_params)
    @comment.user = current_user

    if comment_params[:parent_id].present?
      partial = 'comments/reply'
    else
      partial = 'comments/comment'
    end

    if @comment.save
      respond_to do |format|
        format.js { render partial: partial, locals: { comment: @comment } }
      end
    else
      respond_to do |format|
        format.js { head :unprocessable_entity }
      end
    end
  end


  def replies
    @parent_comment = Comment.find(params[:id])
    @replies = @parent_comment.replies.includes(:user).order(created_at: :desc)
  end


  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :product_id, :parent_comment_id)
  end

end
