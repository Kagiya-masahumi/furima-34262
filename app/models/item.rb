class Item < ApplicationRecord

  has_one :order
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :carry_area, :carry_date, :postage, :status, :category

  validates :name, :explain,:image, presence: true
  validates :status_id, :category_id, :carry_area_id, :carry_date_id, :postage_id, numericality: { other_than: 1 ,message: 'を選択してください'}
  validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}

end
