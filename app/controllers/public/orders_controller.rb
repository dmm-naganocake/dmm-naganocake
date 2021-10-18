class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def check
  end

  def create
    @order = Order.new(order_params)
    p @order
    @order.save
    redirect_to request.referer
  end

  def finish
  end

  def index
  end

  def show
  end
  
  private
  def order_params
    params.require(:order).permit(:postal_code,:address,:name,:payment_method,:status)
  end
end
