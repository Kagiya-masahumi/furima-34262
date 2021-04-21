require 'rails_helper'

RSpec.describe "OrderAddresses", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @another_item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
  end

  describe '商品購入機能' do
    context '商品購入情報の登録ができる時' do

      it 'ログイン状態のユーザーのみ、商品購入ページへ遷移できること' do
        sign_in(@user)
        visit item_path(@another_item.id)
        expect(page).to have_content("購入画面に進む")
        click_on "購入画面に進む"
        expect(current_path).to eq(item_orders_path(@another_item.id))
      end

      it 'ログイン状態のユーザーのみ、商品購入ページへ遷移できること' do
        sign_in(@user)
        item_order(@another_item)
        expect{
          click_button '購入'
        }.to change{ Order.count }.by(1)
        expect(current_path).to eq(root_path)
      end


    end

    context '商品購入ができない時' do 
    
      it 'ログアウト状態のユーザーは、商品の詳細へ遷移しても、「購入する」ボタンが表示されないこと' do
        visit root_path
        visit item_path(@another_item.id)
        expect(current_path).to have_no_content("購入画面に進む")
      end

      it '入力に問題がある状態で「購入」ボタンが押された場合、情報は保存されず、購入ページに戻りエラーメッセージが表示されること' do
        sign_in(@user)
        visit item_orders_path(@another_item.id)
        expect(current_path).to eq(item_orders_path(@another_item.id))
        fill_in 'card-number', with: ''
        fill_in 'card-exp-month', with: ''
        fill_in 'card-exp-year', with: ''
        fill_in 'card-cvc', with: ''
        fill_in 'postal-code', with: ''
        select "東京都", from: "prefecture"
        fill_in 'city', with: ''
        fill_in 'addresses', with: '旭ヶ丘'
        fill_in 'phone-number', with: '090'
        expect{
          click_button '購入'
        }.not_to change{ Order.count }
        expect(current_path).to eq(item_orders_path(@another_item.id))
        expect(page).to have_content('を入力してください')
      end

    end
  end

end
