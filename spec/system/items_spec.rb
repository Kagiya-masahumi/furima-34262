require 'rails_helper'

RSpec.describe "Items", type: :system do
  before do
    @item = FactoryBot.create(:item)
    @user = FactoryBot.create(:user)
    Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/images/sample.png'))
  end
  

  describe '商品出品機能' do
    context '商品出品情報の登録ができる時' do

      it 'ログイン状態のユーザーのみ、商品出品ページへ遷移できること' do
        sign_in(@user)
        click_on '出品する'
        expect(current_path).to eq(new_item_path)
      end

      it '必要な情報を適切に入力すると、商品情報がデータベースに保存されること' do 
        sign_in(@user)
        visit new_item_path
        attach_file "item-image", "public/images/sample.png"
        fill_in 'item[name]', with: @item.name
        fill_in 'item[explain]', with: @item.explain
        select "メンズ", from: "item[category_id]"
        select "未使用に近い", from: "item[status_id]"
        select "着払い(購入者負担)", from: "item[postage_id]"
        select "東京都", from: "item[carry_area_id]"
        select "2~3日で発送", from: "item[carry_date_id]"
        fill_in 'item[price]', with: @item.price

        expect {
          click_on '出品する'
        }.to change{ Item.count }.by(1)
        expect(current_path).to eq(root_path)
      end
    end

    context '商品出品情報の登録ができない時' do 
    
      it 'ログアウト状態のユーザーは、商品出品ページへ遷移しようとすると、ログインページへ遷移すること' do
        visit root_path
        click_on '出品する'
        expect(current_path).to eq(new_user_session_path)
      end

      it '入力に問題がある状態で「出品する」ボタンが押された場合、情報は保存されず、出品ページに戻りエラーメッセージが表示されること' do
        sign_in(@user)
        visit new_item_path
        @item.name = ''
        expect {
        click_on '出品する'
        }.not_to change{ Item.count }
        expect(current_path).to eq(items_path)
        expect(page).to have_content('を入力してください')
      end

    end
  end
  
  #入力された販売価格によって、販売手数料や販売利益の表示が変わること
  #必要な情報を適切に入力すると、商品情報がデータベースに保存されること
  #エラーハンドリングができていること（入力に問題がある状態で「出品する」ボタンが押された場合、情報は保存されず、出品ページに戻りエラーメッセージが表示されること）
  #エラーハンドリングの際、1つのエラーに対して同じエラーメッセージが重複して表示されないこと

end