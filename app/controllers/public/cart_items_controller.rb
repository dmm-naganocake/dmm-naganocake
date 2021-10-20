class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items.all

    @total_payment = 0
    @cart_items.each do |cart_item|
      @total_payment = @total_payment + cart_item.item.price * cart_item.amount
    end
  end

  def create

    # アイテムを特定
    @cart_item = CartItem.new(cart_item_params)

    @cart_item.customer_id = current_customer.id

    @cart_item.save
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to request.referer
  end

  def all_destroy
    @cart_items = current_customer.cart_items
    @cart_items.destroy
    redirect_to items_path
  end

  def update
    @cart_item = CartItem.find(params[:id])
    # あれ、URLに:idがないけどなんでうまく特定できるんだ？
    @cart_item.update(cart_item_params)
    redirect_to request.referer
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id,:amount)
  end
end
