class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @product, notice: 'Comment was successfully created.'
    else
      redirect_to @product, alert: 'Error creating comment.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :product_id, :parent_comment_id)
  end

end
