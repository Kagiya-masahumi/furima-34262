require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe 'ユーザー新規登録' do
    before do
      user = FactoryBot.build(:user)
      item = FactoryBot.build(:item)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
    end

    context '購入できる場合' do
      it 'すべての値が正しく入力されていれば購入できること' do
        expect(@order_address).to be_valid
      end

      it 'buildingは空でも購入できること' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end

    end
    
    context '購入できない場合' do


      it "クレジットカード情報が空では登録できないこと" do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end

      it "user_idが空では登録できないこと" do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end

      it "item_idが空では登録できないこと" do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end

      it 'postal_numが空だと購入できないこと' do
        @order_address.postal_num = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal num can't be blank")
      end

      it 'postal_numが半角のハイフンを含んだ正しい形式でないと購入できないこと' do
        @order_address.postal_num = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal num is invalid. Include hyphen(-)')
      end

      it 'prefectureを選択していないと購入できないこと' do
        @order_address.prefecture = 0
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'cityは空だと購入できないこと' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      
      it 'addressは空だと購入できないこと' do
        @order_address.address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address can't be blank")
      end
      
      it 'phone_numが全角数字だと購入できないこと' do
        @order_address.phone_num = '０９０１２３４５６７８'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone num is invalid')
      end

      it 'phone_numにハイフンが記述されていると購入できないこと' do
        @order_address.phone_num = '090-1234-5678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone num is invalid')
      end

      it 'phone_numが11文字以上では購入できないこと' do
        @order_address.phone_num = '090123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone num is invalid')
      end

      it 'postal_numが英数字混合だと購入できないこと' do
        @order_address.postal_num = '1a2b3c4d5e6'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal num is invalid. Include hyphen(-)")
      end

    end
  end
end
