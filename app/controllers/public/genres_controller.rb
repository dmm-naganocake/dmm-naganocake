class Public::GenresController < ApplicationController
  def show
    @genres = Genre.all
    @genre =Genre.find(params[:id])

    # @item = Item.find(params[:id])
    # @item = @genre.item.find(params[:id])

  end


end
