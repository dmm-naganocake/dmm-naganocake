class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end

  def check
        @order = Order.new(order_params)
        @cart_items = CartItem.where(customer_id: current_customer.id)

        # @cart_items = current_customer.cart_itemsとしても同じ
        @total_payment = 0
        @cart_items.each do |cart_item|
          @total_payment = @total_payment + cart_item.item.price * cart_item.amount
        end
        @total_payment = @total_payment + 800

        if params[:order][:address_number] == '0'
          @order.postal_code = current_customer.postal_code
          @order.address = current_customer.address
          @order.name = current_customer.last_name + current_customer.first_name
          @order.shipping_cost = 800
          @order.status = 0
          @order.total_payment = @total_payment
          @order.payment_method = params[:order][:payment_method]
        elsif params[:order][:address_number] == '1'
          @selected_address = Address.find(params[:order][:address_id])
          @order.postal_code = @selected_address.postal_code
          @order.address = @selected_address.address
          @order.name = @selected_address.name
          @order.shipping_cost = 800
          @order.status = 0
          @order.total_payment = @total_payment
          @order.payment_method = params[:order][:payment_method]
        elsif params[:order][:address_number] == '2'
          @order.postal_code = params[:order][:postal_code]
          @order.address = params[:order][:address]
          @order.name = params[:order][:name]
          @order.shipping_cost = 800
          @order.status = 0
          @order.total_payment = @total_payment
          @order.payment_method = params[:order][:payment_method]
        else
        end
  end

  def create

    @order =Order.create(order_params)
    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.item_id =cart_item.item.id
      @order_detail.price =cart_item.item.price
      @order_detail.amount =cart_item.amount
      @order_detail.making_status = 0
      @order_detail.order_id =@order.id
      @order_detail.save
      cart_item.destroy
    end
    render :finish
    # なぜredirect_toだとうまくいかない？
    # ログインしてる顧客のカートアイテムを回してorderに紐づいてるorder_datailに無いカラムを定義する
    # それをsaveしてindexの@ordersはorder_detailに紐ついてるのでeach文の入れ子によって保存されたカラムを呼び出せている

  end

  def finish
  end

  def index
   @orders = Order.where(customer_id: current_customer.id)
  # @order.items = current_customer.items.all
  end

  def show
    @order = Order.find(params[:id])
    # @cart_item = CartItem.find(params[:id])
  end

  private
  def order_params
    params.require(:order).permit(:postal_code,:address,:name,:payment_method,:shipping_cost,:total_payment,:status,:customer_id)

  end

end
