class OrderAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_num, :prefecture_id, :city, :address, :building, :phone_num

  with_options presence: true do
    validates :user_id
    validates :item_id 
    validates :postal_num
    validates :prefecture
    validates :city
    validates :address
    validates :phone_num
  end

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(postal_code: postal_code,
                    prefecture: prefecture, 
                    city: city, 
                    address: address, 
                    building: building,
                    phone_num: phone_num,
                    order_id: order.id)
  end


end