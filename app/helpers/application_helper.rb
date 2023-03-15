


module ApplicationHelper
  include CloudinaryHelper

  def generate_tiled_background(list, default_color = "gray")
    products = list.products
    tiles = []

    products.each do |product|
      if product.photos.attached?
        tiles << "<div class='tile' style='background-image: url(#{cl_image_path(product.photos.first.key)})'></div>"
      end
    end

    while tiles.count < 8
      tiles << "<div class='tile' style='background-image: linear-gradient(#{default_color}, #{default_color})'></div>"
    end

    tiles.join.html_safe
  end




end
