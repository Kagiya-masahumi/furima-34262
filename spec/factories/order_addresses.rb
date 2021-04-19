FactoryBot.define do
  factory :order_address do
    postal_num    { '123-4567' }
    prefecture    { 1 }
    city          { '練馬区' }
    address       { '旭ヶ丘1-1' }
    building      { '東京ハイツ' }
    phone_num     { '09012345678'}
    token         {"tok_abcdefghijk00000000000000000"}
    

  end
end
