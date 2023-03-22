class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    bookmark = current_user.bookmarks.build(product_id: params[:product_id])

    if bookmark.save
      flash[:notice] = 'Product bookmarked successfully'
    else
      flash[:alert] = 'Failed to bookmark the product'
    end
    redirect_to products_path
  end

  def destroy
    bookmark = current_user.bookmarks.find_by(product_id: params[:product_id])

    if bookmark&.destroy
      flash[:notice] = 'Product unbookmarked successfully'
    else
      flash[:alert] = 'Failed to unbookmark the product'
    end
    redirect_to products_path
  end
  
end
