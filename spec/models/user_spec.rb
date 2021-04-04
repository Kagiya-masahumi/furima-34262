require 'rails_helper'



RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end



  describe 'ユーザー新規登録' do

    it 'メールアドレスが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")

    end

    it 'メールアドレスが一意性であること' do
      @user.save
      another_user = FactoryBot.build(:user, email:@user.email)
      another_user.valid?
      binding.pry
      expect(@user.errors.full_messages).to include("Email is already have")
    end

    it 'メールアドレスは、@を含む必要があること' do
      @user.email = 'test.sample'
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it 'パスワードが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'パスワードは、6文字以上での入力が必須であること（6文字が入力されていれば、登録が可能なこと）' do
      @user.password = '1a2b3'
      @user.password_confirmation = '1a2b3'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it ' パスワードは、半角英数字混合での入力が必須であること（半角英数字が混合されていれば、登録が可能なこと）' do
      @user.password = '111111'
      @user.password_confirmation = '111111'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password は6文字以上かつ英数字をそれぞれ含めてください")
    end

    it 'パスワードは、確認用を含めて2回入力すること' do
      @user.password = ''
      @user.password_confirmation = '1a2b3c'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")

    end


    it 'パスワードとパスワード(確認用)の値の一致が必須であること' do
      @user.password = '123456'
      @user.password_confirmation = '1a2b3c'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'ニックネームが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end


    ## 新規登録/本人情報確認
    it 'ユーザー本名は、名字と名前がそれぞれ必須であること' do
      @user.name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it 'ユーザー本名は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.name = 'yamanaka'
      @user.valid?
      expect(@user.errors.full_messages).to include("Name に全角文字を使用してください")
    end

    it 'ユーザー本名のフリガナは、名字と名前がそれぞれ必須であること' do
      @user.name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Name kana can't be blank")
    end

    it 'ユーザー本名のフリガナは、全角（カタカナ）での入力が必須であること' do
      @user.name_kana = '太郎'
      @user.valid?
      expect(@user.errors.full_messages).to include("Name kana はカタカナで入力して下さい。")
    end

    it '生年月日が必須であること' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end

  end

end
