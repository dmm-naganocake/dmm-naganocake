class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end

  def check
    # @order = current_customer.order.new
    # @cart_items = current_customer.cart_items
    # @order.shipping_cost = 1000
    # @total_payment = 0
    # @cart_items.each do |cart_item|
    #   @total_payment = @total_payment + cart_item.item.price * cart_item.amount
    # end
    # @total_payment = @order.shipping_cost + @total_payment
    # @order.total_payment = @total_payment
    # @order.customer_id = current_customer.id
    # @my_address = Address.where(customer_id: current_customer.id)
    # @order.status=0

    # if prams[:order][:address] == '0'
    #   # 既存の住所
    #   @postal_code = current_customer.postal_code
    #   @address =current_customer.address
    #   @name = current_customer.name
    # elsif prams[:order][:address] == '1'
    #   # 住所選択
    #   @postal_code = @my_address.pluck(:postal_code).slice!(0)
    #   # slice!=選択範囲
    #   @address = @my_address.plick(:address).slice!(0)
    #   @name = @my_address.pluck(:name).slice!(0)
    # elsif prams[:order][:address] == '2'
    #   # 住所入力
    #   @postal_code = @order.postal_code
    #   @address = @order.address
    #   @name = @order.name
    # end
  #     render :check
        @order = Order.new(order_params)
        @cart_items = CartItem.where(customer_id: current_customer.id)

        # @cart_items = current_customer.cart_itemsとしても同じはず
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
    # @cart_items = CartItem.where(customer_id: current_customer.id)
    # if @order =Order.create(order_params)
    #   @cart_items.each do |cart_item|
    #     OrderDetails.create()
    #   end
    # end
    @order =Order.create(order_params)
    redirect_to customers_my_page_path

  end

  def finish
  end

  def index
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:postal_code,:address,:name,:payment_method,:shipping_cost,:total_payment,:status,:customer_id)

  end

end
