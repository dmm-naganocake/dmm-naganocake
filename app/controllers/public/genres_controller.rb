class Public::GenresController < ApplicationController
  def show
    @genres = Genre.all
    @genre =Genre.find(params[:id])
<<<<<<< HEAD
    # @item = Item.find(params[:id])
=======
    # @item = @genre.item.find(params[:id]) 
>>>>>>> ef19c338049ce0d473f07018753a0165b60c5615
  end


end
