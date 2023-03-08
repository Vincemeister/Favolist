class ProductsController < ApplicationController

  @products = Product.where(user_id: current_user.id || current_user.following.ids)

end
