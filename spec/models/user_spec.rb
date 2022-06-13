require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context 'ユーザー新規登録が出来る場合' do
      it 'ユーザー情報(nickname,email,password,password_confirmation)及び本人情報(last_name,first_name,last_name_kana,first_name_kana,birth_date)が存在すれば登録出来る' do
        expect(@user).to be_valid
      end
    end
    context 'ユーザー新規登録が出来ない場合' do
      it 'nicknameが空では登録出来ない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録出来ない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it '重複したemailが存在する場合は登録出来ない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailは@を含まないと登録出来ない' do
        @user.password = 'aaaagmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'passwordが空では登録出来ない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = 'aaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordは半角英数字を含んでいないと登録できない' do
        @user.password = 'パスワードです'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid. Include both letters and numbers.')
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '1234567'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'last_nameとfirst_nameが其々空では登録出来ない' do
        @user.last_name = ''
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank", "First name can't be blank")
      end

      it 'last_nameとfirst_nameが半角(漢字・ひらがな・カタカナ)だと登録出来ない' do
        @user.last_name = 'ﾀﾅｶ'
        @user.first_name = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters.',
                                                      'First name is invalid. Input full-width characters.')
      end

      it 'last_name_kanaとfirst_name_kanaが其々空では登録出来ない' do
        @user.last_name_kana = ''
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank", "First name kana can't be blank")
      end

      it 'last_name_kanaとfirst_name_kanaが半角(カタカナ)だと登録出来ない' do
        @user.last_name_kana = 'ﾀﾅｶ'
        @user.first_name_kana = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters.',
                                                      'First name kana is invalid. Input full-width katakana characters.')
      end

      it 'birth_dateが空では登録出来ない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
