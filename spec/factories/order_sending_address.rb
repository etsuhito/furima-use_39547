FactoryBot.define do
  factory :order_sending_address do
    post_code { '123-4567' }
    prefecture_id { 1 }
    city { '東京都' }
    street { '1-1' }
    building_name { '東京ハイツ' }
    phone_num { '09012345678' }
    token {"tok_abcdefghijk00000000000000000"}
  end
end