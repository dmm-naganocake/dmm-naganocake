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
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to request.referer
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to new_address_path
  end

  private

  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end
end
