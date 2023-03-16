class ListsController < ApplicationController

  def show
    @list = List.find(params[:id])
    @products = @list.products
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.user = User.find(params[:user_id])
    if @list.save
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  private

  def list_params
    params.require(:list).permit(:title)
  end
end
