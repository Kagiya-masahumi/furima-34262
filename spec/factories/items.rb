FactoryBot.define do
  factory :item do
    id            {2}
    name          {"商品名"}
    explain       {"商品です"}
    status_id     {2}
    category_id   {2}
    carry_area_id {2}
    carry_date_id {2}
    postage_id    {2}
    price         {3500}
    user
    

    after(:build) do |item|
      item.image.attach(io:File.open('public/images/sample.png'),filename: 'sample.png')
    end

  end
end
