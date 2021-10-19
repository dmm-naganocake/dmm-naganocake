class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def quit
  end

  def withdraw
  end

  def edit
    @customer = current_customer
  end

  def update
  end
end
