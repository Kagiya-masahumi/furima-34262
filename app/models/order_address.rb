class OrderAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_num, :prefecture_id, :city, :address, :building, :phone_num

  with_options presence: true do
    validates :user_id
    validates :item_id 
    validates :postal_num,format:{with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture
    validates :city
    validates :address
    validates :phone_num, format:{with: /\A[0-9]{11}\z/}
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