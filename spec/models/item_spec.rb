require 'rails_helper'


RSpec.describe Item, type: :model do
  before do 
    @item = FactoryBot.create(:item)
  end



  describe '商品出品機能の実装' do
    context '商品の出品ができる時' do
      
      it '販売価格は、¥300~¥9,999,999の間のみ登録可能であること' do
        @item.price = 10000
        expect(@item).to be_valid
      end

      it '販売価格は、販売価格は半角数字なら登録可能であること' do 
        @item.price = 10000
        expect(@item).to be_valid
      end

      it '入力された販売価格によって、販売手数料や販売利益の表示が変わること' do
      end
      

    end


    context '商品の出品ができない時' do
      it 'ログアウト状態のユーザーは、商品出品ページへ遷移しようとすると、ログインページへ遷移すること' do
        
      end
      
      it '商品画像がなければ登録できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が空だと登録できないこと' do 
        @item.name = ''
        @item.valid?

        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      
      it '商品の説明が空だと登録できないこと' do 
        @item.explain = ''
        @item.valid?

        expect(@item.errors.full_messages).to include("Explain can't be blank")
      end

      it 'カテゴリーの情報が未選択だと登録できないこと' do 
        @item.category_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category is not a number")
      end

      it 'カテゴリーの選択肢が1だと登録できないこと' do 
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end

      it '配送料の情報が未選択だと登録できないこと' do
        @item.postage_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage is not a number")
      end

      it '配送料の選択肢が1だと登録できないこと' do 
        @item.postage_id = 1
        @item.valid?

        expect(@item.errors.full_messages).to include("Postage must be other than 1")
      end

      it '発送元の地域が未選択だと登録できないこと' do
        @item.carry_area_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Carry area is not a number") 
      end

      it '発送元の地域の選択肢が1だと登録できないこと' do 
        @item.carry_area_id = 1
        @item.valid?

        expect(@item.errors.full_messages).to include("Carry area must be other than 1")
      end

      it '発送までの日数が未選択だと登録できないこと' do
        @item.carry_date_id = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Carry date is not a number") 
      end

      it '発送までの日数の選択肢が1だと登録できないこと' do 
        @item.carry_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Carry date must be other than 1")
      end

      it '販売価格の情報が空だと登録できないこと' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank") 
      end

      it '販売価格は、300円以下だと登録できないこと' do 
        @item.price = 290
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than or equal to 300") 
      end

      it '販売価格は、は9,999,999円以上だと登録できないこと' do 
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be less than or equal to 9999999") 
      end

      

      it '販売価格は、全角では登録できないこと' do 
        @item.price = "１２３４５６"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number") 
      end

      it '販売価格は、英字では登録できないこと' do 
        @item.price = "oneHundredYen"
        @item.valid?

        expect(@item.errors.full_messages).to include("Price is not a number") 
      end

      it '販売価格は、漢字では登録できないこと' do
        @item.price = "三千五百円"
        @item.valid?

        expect(@item.errors.full_messages).to include("Price is not a number")  
      end

      it '入力に問題がある状態で「出品する」ボタンが押された場合、情報は保存されず、出品ページに戻りエラーメッセージが表示されること' do 
      end

      it '1つのエラーに対して同じエラーメッセージが重複して表示されないこと' do 
      end

    end
  
  end
end


