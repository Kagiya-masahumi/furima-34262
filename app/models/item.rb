class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :status, :category, :carry_date, :carry_area, :postage

  has_one :order
  belongs_to :user 
  has_one_attached :image

end
