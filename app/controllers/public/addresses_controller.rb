class Public::AddressesController < ApplicationController
  def new
    @addresses = Address.all
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    p @address
    @address.save
    redirect_to request.referer
  end

  def destroy
  end

  def edit
  end

  def update
  end

  private

  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end
end
