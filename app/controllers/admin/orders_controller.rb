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
    @order = Order.find(params[:id])
    @order.update(order_params)
    if @order.status == "payment_confirmation"
      @order_details = @order.order_details
      @order_details.each do |order_detail|
        order_detail.making_status = "production_pending"
        order_detail.save
      end
    end
    redirect_to request.referer
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end
