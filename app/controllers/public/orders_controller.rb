class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
  end

  def check
    # p params[:payment_method]
    # p params[:option]
    @order = current_customer.orders.new

    @cart_items = current_customer.cart_items
    @total_payment = 0
    @cart_items.each do |cart_item|
      @total_payment = @total_payment + cart_item.item.price * cart_item.amount
    end
    @total_payment = @total_payment + 800


    if params[:order][:option] == 1
      @order.customer_id = current_customer.id
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code
      @order.name = current_customer.name
      @order.payment_method = params[:payment_method]
      @order.status = 0
      @order.shipping_cost = 800
      @order.total_payment = @total_payment
    end

    render :check
  end

  def create
    # binding.pry
    @order = Order.new(order_params)
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
    params.require(:order).permit(:postal_code,:address,:name,:payment_method,:status,:shipping_cost,:total_payment)
  end
end
