class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
  
    
  validates :nickname, :name,:family_name,:birthday,presence: true 
  validates :email,presence: true, uniqueness: true
  validates_format_of :name_kana,:family_name_kana, presence: true, with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)[a-zA-Z\d]{6,100}+\z/.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'パスワードには英字と数字の両方を含めて設定してください'

    has_many :items, dependent: :destroy
    has_many :orders
end
