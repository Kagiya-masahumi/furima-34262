require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe 'ユーザー新規登録' do
    before do
      user = FactoryBot.build(:user)
      item = FactoryBot.build(:item)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
    end

    context '購入できる場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_address).to be_valid
      end

      it 'buildingは空でも購入できること' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end

    end

    #商品購入ページでは、一覧や詳細ページで選択した商品の情報（商品名・商品画像・販売金額・配送料負担）が、見本アプリと同様の形で出力されること
    #ログアウト状態のユーザーは、URLを直接入力して商品購入ページに遷移しようとすると、商品の販売状況に関わらずログインページに遷移すること
    #ログイン状態の出品者が、URLを直接入力して自身の出品した商品購入ページに遷移しようとすると、トップページに遷移すること
    #ログイン状態のユーザーが、URLを直接入力して売却済み商品の商品購入ページへ遷移しようとすると、トップページに遷移すること
    #クレジットカード決済ができること
    #クレジットカードの情報は購入の都度入力させること
    #クレジットカード情報は必須であり、正しいクレジットカードの情報で無いときは決済できないこと
    #配送先の住所情報も購入の都度入力させること
    #配送先の情報として、郵便番号・都道府県・市区町村・番地・電話番号が必須であること
    
    #購入が完了したら、トップページまたは購入完了ページに遷移すること
    
    #売却済みの商品は、画像上に『sold out』の文字が表示されるようになっていること（商品一覧機能）
    #売却済みの商品は、画像上に『sold out』の文字が表示されるようになっていること（商品詳細機能）
    #ログイン状態の出品者でも、売却済みの商品に対しては「編集・削除ボタン」が表示されないこと（商品詳細機能）
    #ログイン状態の出品者以外のユーザーでも、売却済みの商品に対しては「購入画面に進む」ボタンが表示されないこと（商品詳細機能）
    #ログイン状態の出品者であっても、URLを直接入力して自身の売却済み商品の商品情報編集ページへ遷移しようとすると、トップページに遷移すること（商品情報編集機能）
    





    context '購入できない場合' do


      it "tokenが空では登録できないこと" do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
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
    end
  end
end
