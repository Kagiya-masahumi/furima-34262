require 'rails_helper'



RSpec.describe "ユーザーログイン機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  it 'ログアウト状態では、ヘッダーに新規登録/ログインボタンが表示されることを確認する' do
    visit root_path 
    expect(page).to have_content("新規登録")
    expect(page).to have_content("ログイン")
  end

  it 'ログイン状態では、ヘッダーにユーザーのニックネーム/ログアウトボタンが表示されることを確認する'do
    visit new_user_session_path 
    fill_in 'email',with: @user.email
    fill_in 'password',with: @user.password
    find('input[name="commit"]').click
    visit root_path
    expect(page).to have_content("ログアウト")
    expect(page).to have_content(@user.nickname)
  end

  it 'ヘッダーの新規登録ボタンをクリックすることで、新規登録ページに遷移できることを確認する' do
    visit root_path 
    click_on("新規登録")
    expect(current_path).to eq(new_user_registration_path)
  end

  it 'ヘッダーのログインボタンをクリックすることで、ログインページに遷移できることを確認する' do
    visit root_path 
    click_on("ログイン")
    expect(current_path).to eq(new_user_session_path)
  end

  it 'ヘッダーのログアウトボタンをクリックすることで、ログアウトができることを確認する' do
    visit new_user_session_path 
    fill_in 'email',with: @user.email
    fill_in 'password',with: @user.password
    find('input[name="commit"]').click
    visit root_path
    find_link('ログアウト', href:'/users/sign_out').click
    expect(current_path).to eq(root_path)
    expect(page).to have_no_content(@user.nickname)
    expect(page).to have_no_content("ログアウト")

  end

end
