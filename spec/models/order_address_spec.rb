require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '購入できる場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        binding.pry
        expect(@order_address).to be_valid
      end

    end

    context '購入できない場合' do
      it 'postal_numが空だと購入できないこと' do
        @order_address.postal_num = ''
        @order_address.valid?
        binding.pry
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_numが半角のハイフンを含んだ正しい形式でないと購入できないこと' do
        @order_address.postal_num = '1234567'
        @order_address.valid?
        binding.pry
        expect(@order_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end

      it 'prefectureを選択していないと購入できないこと' do
        @order_address.prefecture = 0
        @order_address.valid?
        binding.pry
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'cityは空だと購入できないこと' do
        @order_address.city = ''
        @order_address.valid?
        binding.pry
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      
      it 'addressは空だと購入できないこと' do
        @order_address.address = ''
        @order_address.valid?
        binding.pry
        expect(@order_address.errors.full_messages).to include("Address can't be blank")
      end

      it 'buildingは空だと購入できないこと' do
        @order_address.building = ''
        @order_address.valid?
        binding.pry
        expect(@order_address.errors.full_messages).to include("Building can't be blank")
      end

      
      it 'phone_numが全角数字だと購入できないこと' do
        @donation_address.price = '０９０１２３４５６７８'
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include('Phone_num is invalid')
      end

      it 'phone_numにハイフンが記述されていると購入できないこと' do
        @donation_address.price = '090-1234-5678'
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include('Phone_num is invalid')
      end

      it 'phone_numが11文字以上では購入できないこと' do
        @donation_address.price = '090123456789'
        @donation_address.valid?
        expect(@donation_address.errors.full_messages).to include('Phone_num is invalid')
      end
    end
  end
end
