FactoryBot.define do
  factory :order_address do
    postal_num { '123-4567' }
    prefecture { 1 }
    city { '東京都' }
    address { '1-1' }
    building { '東京ハイツ' }
  end
end
