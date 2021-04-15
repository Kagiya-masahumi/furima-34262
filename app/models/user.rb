class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
  
    
  validates :nickname,:birthday,presence: true 
  validates_format_of :name_kana,:family_name_kana, presence: true,
                      with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい'
  validates :password,
            format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: "は6文字以上かつ英数字をそれぞれ含めてください" }
  with_options presence: true, format: { with: /\A[ぁ-ゔァ-ヴ\p{Ideographic}ａ-ｚＡ-Ｚ０-９]+\z/, message: 'に全角文字を使用してください' } do
    validates :family_name
    validates :name
  end

    
    has_many :items, dependent: :destroy 
    has_many :orders
end
