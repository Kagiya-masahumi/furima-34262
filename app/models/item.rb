class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :status, :category, :carry_date, :carry_area, :postage

  has_one :order
  belongs_to :user 
  has_one_attached :image

  validates :name, :explain, presence: true
  validates :status_id, :category_id, :carry_area_id, :carry_date_id, :postage_id, numericality: { other_than: 1 }

end
