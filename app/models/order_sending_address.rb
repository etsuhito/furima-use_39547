class OrderSendingAddress < ApplicationRecord
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture, :city, :house_number, :building_name, :price, :user_id
  :item_id, :user_id, :post_code, :prefectuer_id, :city, :street, :building_name, :phone_num, :order, :, 
  
  with_options presence: true do
    validates :user_id, :city, :strret, :, :item_id
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id, numericality: { other_than: 1 , message: "を選択してください"}
    validates :phone_number, length: {minimum: 10, message: "は10桁以上を入力してください"}, format: {with: /\A[0-9]{10,11}\z/, message: "は半角数値を入力してください"}
  end
  validates :prefecture, numericality: {other_than: 0, message: "can't be blank"}

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
  
    Shipping_address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, street: street, building_name: building_name, phone_num: phone_num, order.id: order.id)
  
  end
end
