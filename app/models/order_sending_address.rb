class OrderSendingAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :city, :street, :building_name, :phone_num, :order, :token

  with_options presence: true do
    validates :user_id, :city, :street, :item_id, :token
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :phone_num, format: { with: /\A[0-9]{10,11}\z/, message: 'は半角数値を入力してください' }
  end
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }

  def save
    order = Order.create(user_id:, item_id:)

    SendingAddress.create(post_code:, prefecture_id:, city:, street:,
                          building_name:, phone_num:, order_id: order.id)
  end
end
