class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]
  before_action :authenticate_user!
  before_action :set_user, only: [:index, :create]

  def index
    @order_sending_address = OrderSendingAddress.new
  end

  def create
    #binding.pry
    @order_sending_address = OrderSendingAddress.new(order_params)
    #binding.pry
    if @order_sending_address.valid?
      #binding.pry
      pay_item
      @order_sending_address.save
      
       return redirect_to root_path, notice: '注文が完了しました。'
     else
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_sending_address).permit(
      :post_code,
      :prefecture_id, 
      :city, 
      :street,
      :building_name,
      :phone_num,
      :order,
      :token
    ).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end


  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # 自身のPAY.JPテスト秘密鍵を記述→環境変数に置き換え済
    
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
    
  end
end

