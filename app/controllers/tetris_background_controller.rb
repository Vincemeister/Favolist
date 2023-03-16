class TetrisBackgroundController < ApplicationController

  def index
    @product_images = load_product_images
  end

  private

  def load_product_images
    product_images = []
    Product.all.each do |product|
      if product.photos.attached?
        product_images << cl_image_url(product.photos.first.key)
      end
    end
    product_images
  end
  
end
