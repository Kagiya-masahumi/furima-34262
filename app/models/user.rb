class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  has_many :items, dependent: :destroy
  has_many :orders

  validates :nickname,:email,:password,:name,:name_kana,:family_name,:family_name_kana,:birthday,presence: true

end
