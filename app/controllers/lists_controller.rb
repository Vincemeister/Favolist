class ListsController < ApplicationController

  def show
    @list = List.find(params[:id])
    @products = @list.products
  end
end
