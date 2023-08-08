require 'rails_helper'
RSpec.describe Order, type: :model do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order = FactoryBot.build(:order_sending_address, user_id: user.id, item_id: item.id)
      sleep 0.1
    end
  describe "商品の購入" do
    context '商品の購入ができる場合' do
      it "建物名以外の全ての項目が入力されていれば登録できる" do
      expect(@order).to be_valid
      end
      it "建物名が空でも購入できる" do
        @order.building_name = ''  
        expect(@order).to be_valid
      end
    end
    context '商品の購入ができない場合' do
      it "郵便番号が空だと購入できない" do
        @order.post_code = ''  
        @order.valid?
        expect(@order.errors.full_messages).to include("Post code can't be blank")
      end
      it "郵便番号は「3桁ハイフン4桁」でないと購入できない" do
        @order.post_code = '1111111'  
        @order.valid?
        expect(@order.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
      end
      it "郵便番号は半角文字列でないと購入できない" do
        @order.post_code = 'あ'  
        @order.valid?
        expect(@order.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
      end
      it "都道府県が空だと購入できない" do
        @order.prefecture_id = '0'  
        @order.valid?
        expect(@order.errors.full_messages).to include("Prefecture can't be blank")
      end
      it "市区町村が空だと購入できない" do
        @order.city = ''  
        @order.valid?
        expect(@order.errors.full_messages).to include("City can't be blank")
      end
      it "番地が空だと購入できない" do
        @order.street = ''  
        @order.valid?
        expect(@order.errors.full_messages).to include("Street can't be blank")
      end
      it "電話番号が空だと購入できない" do
        @order.phone_num = ''  
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone num can't be blank")
      end
      it "電話番号が9桁以下だと購入できない" do
        @order.phone_num = '12345678'  
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone num は半角数値を入力してください")
      end
      it "電話番号が12桁以上だと購入できない" do
        @order.phone_num = '123412341234'  
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone num は半角数値を入力してください")
      end
      it "電話番号が半角数値でないと購入できない" do
        @order.phone_num = '３３３'  
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone num は半角数値を入力してください")
      end
      it "ユーザーが紐付けられていないと購入できない" do
        @order.user_id = nil  
        @order.valid?
        expect(@order.errors.full_messages).to include("User can't be blank")
      end
      it "商品情報が空だと購入できない" do
        @order.item_id = nil  
        @order.valid?
        expect(@order.errors.full_messages).to include("Item can't be blank")
      end
      it "tokenが空だと購入できない" do
        @order.token = nil  
        @order.valid?
        expect(@order.errors.full_messages).to include("Token can't be blank")
     end
   end
  end
end