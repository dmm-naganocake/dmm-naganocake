class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order=Order.find(params[:id])
    @order_details = @order.order_details
    @total_payment = 0
    @order_details.each do |order_item|
      @total_payment += order_item.price * order_item.amount
    end
  end

  def update

  end


end
