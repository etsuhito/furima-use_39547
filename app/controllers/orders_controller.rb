class OrdersController < ApplicationController
  before_action :select_item, only: [:index, :create]
  before_action :authenticate_user!
  before_action :select_user, only: [:index, :create]

  def index
    @order_sending_address = OrderSendingAddress.new
  end

  def create
    @order_sending_address = OrderSendingAddress.new(order_params)
    @price = @item.price

    if @order_sending_address.valid?
      @order_sending_address.save
      pay_item
      return redirect_to root_path
    else
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_sending_address).permit(
      :postal_code,
      :prefecture_id, 
      :city, 
      :street,
      :building_name,
      :phone_num,
      :order
   )merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

end
