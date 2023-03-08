class ProductsController < ApplicationController
  def index
    @products = Product.where(list_id: List.where(user: current_user.following).or(List.where(user: current_user)))
  end
end
