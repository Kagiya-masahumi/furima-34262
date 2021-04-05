require 'rails_helper'



RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end



  describe 'ユーザー新規登録' do
    context 'ユーザーの新規登録ができる時' do 
      it '登録に必要な情報が存在すれば登録できること' do
        expect(@user).to be_valid
      end

      it ' パスワードは、半角英数字混合での入力であれば登録ができること' do
        @user.password = '1a2b3c'
        @user.password_confirmation = '1a2b3c'
        expect(@user).to be_valid
      end

      it 'ユーザー本名は、全角（漢字・ひらがな・カタカナ）での入力があれば登録できること' do
        @user.name = 'たろう'
        @user.family_name = '山中'
        expect(@user).to be_valid
      end

      it 'ユーザー本名のフリガナは、全角（カタカナ）であれば登録できること' do
        @user.name_kana = 'タロウ'
        expect(@user).to be_valid
      end
    end


    context 'ユーザー登録できない時' do
      it 'メールアドレスが空では登録できないこと' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'メールアドレスが一意性でなければ登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user, email:@user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end

      it 'メールアドレスは、@を含めなければ登録できないこと' do
        @user.email = 'test.sample'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it 'パスワードが空では登録できないこと' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードは、6文字以上での入力でなければ登録できないこと' do
        @user.password = '1a2b3'
        @user.password_confirmation = '1a2b3'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it ' パスワードは、半角英数字混合での入力でなければ登録できないこと' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は6文字以上かつ英数字をそれぞれ含めてください")
      end

      it ' パスワードは、英語のみでは登録できないこと' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は6文字以上かつ英数字をそれぞれ含めてください")
      end

      it ' パスワードは、数字のみでは登録できないこと' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は6文字以上かつ英数字をそれぞれ含めてください")
      end

      it ' パスワードは、全角では登録できないこと' do
        @user.password = '１Ａ２Ｂ３Ｃ'
        @user.password_confirmation = '１Ａ２Ｂ３Ｃ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は6文字以上かつ英数字をそれぞれ含めてください")
      end

      it 'パスワードは、確認用を含めて2回入力しなければ登録できないこと' do
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

      it 'ニックネームが空では登録できないこと' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end


      it 'ユーザー本名は、名前が未入力だと登録できないこと' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Name can't be blank")
      end

      it 'ユーザー本名は、名字が未入力だと登録できないこと' do
        @user.family_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end


      it 'ユーザー本名は、半角数字では登録できないこと' do
        @user.name = '16'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name に全角文字を使用してください")
      end

      it 'ユーザー本名は、半角英字では登録できないこと' do
        @user.name = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name に全角文字を使用してください")
      end

      it 'ユーザー本名は、半角カナでは登録できないこと' do
        @user.name = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name に全角文字を使用してください")
      end

      it 'ユーザー本名は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.name = 'yamanaka'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name に全角文字を使用してください")
      end

      it 'ユーザー本名のフリガナは、名字が未入力だと登録できないこと' do
        @user.family_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana はカタカナで入力して下さい")
      end

      it 'ユーザー本名のフリガナは、名前が未入力だと登録できないこと' do
        @user.name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kana はカタカナで入力して下さい")
      end

      it 'ユーザー本名のフリガナは、全角（カタカナ）でなければ登録できないこと' do
        @user.name_kana = '太郎'
        @user.family_name_kana = '山中'
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kana はカタカナで入力して下さい", "Family name kana はカタカナで入力して下さい")
      end

      it '生年月日が未入力だと登録できないこと' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end

  end
end
