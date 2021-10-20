class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    @items = Item.all
    # アプリを完成させよう２の4章のページング機能を参考にpageメソッドを使う
    # rails g kaminari:views bootstrap4とする。defaultではないので注意

  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end
end
