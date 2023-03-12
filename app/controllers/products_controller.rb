class ProductsController < ApplicationController
  def index
    @products = Product.where(list_id: List.where(user: current_user.following).or(List.where(user: current_user)))
  end

  def show
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

  private

  def product_params
    params.require(:product).permit(:title, :price, :review, :description, :referrals, :logo, :list_id, photos: [])
  end
end
