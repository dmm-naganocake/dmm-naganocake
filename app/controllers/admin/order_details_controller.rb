class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    if @order_detail.making_status == "in_production"
      @order_detail.order.status = "in_production"
      @order_detail.order.save
    end
    if @order_detail.making_status == "production_complete"
      @order_detail.order.status = "preparing_delivery"
      @order_detail.order.save
    end
    redirect_to request.referer
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end