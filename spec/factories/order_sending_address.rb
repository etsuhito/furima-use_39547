FactoryBot.define do
  factory :order_sending_address_address do
    post_code { '123-4567' }
    prefecture { 1 }
    city { '東京都' }
    house_number { '1-1' }
    building_name { '東京ハイツ' }
    price { 2000 }
  end
end