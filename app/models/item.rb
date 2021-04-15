class Item < ApplicationRecord

  has_one :order
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :carry_area 
  belongs_to :postage
  belongs_to :carry_date
  belongs_to :status
  belongs_to :category
  

  validates :name, :explain,:image, presence: true
  validates :status_id, :category_id, :carry_area_id, :carry_date_id, :postage_id, numericality: { other_than: 1 }
  validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}

  
end
