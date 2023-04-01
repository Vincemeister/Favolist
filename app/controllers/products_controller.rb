class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :bookmark, :unbookmark]

  # ...

  def index
    if params[:query].present?
      @products = Product.search_by_title_and_description_and_list_title_and_user_username(params[:query])
    else
      @products = Product.where("referrals ILIKE ?", "%FOR THE FEED%").order(created_at: :desc)
    end
  end

  def show
    @product = Product.find(params[:id])
    @comments = @product.comments.includes(:user, replies: :user).where(parent_comment_id: nil).order(created_at: :desc)
    @comment = Comment.new
  end


  def comments
    @product = Product.find(params[:id])
  end


  def new
    @product = Product.new
    @user = current_user
  end

  def create
    @product = Product.new(product_params)
    @product.logo.attach(params[:product][:logo])
    @product.photos.attach(params[:product][:photos])
    if @product.save
      redirect_to list_path(@product.list)
    else
      render :new
    end
  end

  def bookmark
    bookmark = Bookmark.new(user: current_user, product: @product)
    if bookmark.save
      render json: { action: "bookmark", unbookmark_path: unbookmark_product_path(@product) }
    else
      head :unprocessable_entity
    end
  end

  def unbookmark
    bookmark = Bookmark.find_by(user: current_user, product: @product)
    if bookmark.destroy
      render json: { action: "unbookmark", bookmark_path: bookmark_product_path(@product) }
    else
      head :unprocessable_entity
    end
  end



  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :price, :review, :description, :referrals, :logo, :list_id, photos: [])
  end

  def comment_params
    params.require(:comment).permit(:body, :parent_comment_id)
  end
end
