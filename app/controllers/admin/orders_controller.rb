class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order=Order.find(params[:id])
    @order_details=OrderDetail.find_by(order_id: @order.id)
  end

  def update
    order=Order.find(params[:id])
    order_details=OrderDetail.where(order_id: order.id)
    order.update(order_params)
    if params[:order][:status] == "payment_confirmation"
       order_details.each do |order_detail|
         order_detail.update(making_status: 1)
       end
    end
    redirect_to request.referer
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end
