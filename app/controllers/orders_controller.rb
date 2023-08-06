class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :authenticate_user!
  #before_action :set_user, only: [:index, :create]

  def index
    @order_sending_address = OrderSendingAddress.new
  end

  def create
    #binding.pry
    @order_sending_address = OrderSendingAddress.new(order_params)
    #redirect_to "/item/#{order.item.id}"  
    #binding.pry
    if @order_sending_address.valid?
      pay_item
      @order_sending_address.save
      
       return redirect_to root_path, notice: '注文が完了しました。'
     else
      render 'index', status: :unprocessable_entity
    end
  end

  private

  #def set_user
   # @user = User.find(params[:id])
  #end
  
  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_sending_address).permit(
      :postal_code,
      :prefecture_id, 
      :city, 
      :street,
      :building_name,
      :phone_num,
      :order,
    ).merge(user_id: current_user.id, item_id: @item.id)
  end
end
