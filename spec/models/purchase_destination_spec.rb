require 'rails_helper'

RSpec.describe PurchaseDestination, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_destination = FactoryBot.build(:purchase_destination, user_id: user.id, item_id: item.id)
  end

  describe '購入情報の保存' do
    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_destination).to be_valid
      end

      it 'buildingは空でも保存できること' do
        @purchase_destination.building = ''
        expect(@purchase_destination).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'post_codeが空だと保存できないこと' do
        @purchase_destination.post_code = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Post code can't be blank")
      end
      
      it 'post_codeが「3桁ハイフン4桁」以外の形だと保存できないこと' do
        @purchase_destination.post_code = '1234567'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include('Post code is invalid')
      end

      it 'post_codeが全角文字列だと保存できないこと' do
        @purchase_destination.post_code = '１２３−４５６７'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include('Post code is invalid')
      end

      it 'prefecture_idを選択していないと保存できないこと' do
        @purchase_destination.prefecture_id = 1
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include('Prefecture must be other than 1')
      end

      it 'cityが空だと保存できないこと' do
        @purchase_destination.city = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("City can't be blank")
      end

      it 'streetが空だと保存できないこと' do
        @purchase_destination.street = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Street can't be blank")
      end

      it 'phoneが空だと保存できないこと' do
        @purchase_destination.phone = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Phone can't be blank")
      end

      it 'phoneが9桁以下だと保存できないこと' do
        @purchase_destination.phone = '090123456'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include('Phone is invalid')
      end

      it 'phoneが12桁以上だと保存できないこと' do
        @purchase_destination.phone = '090123456789'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include('Phone is invalid')
      end

      it 'phoneが全角数値のみだと保存できないこと' do
        @purchase_destination.phone = '０９０１２３４５６７８'
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include('Phone is invalid')
      end

      it 'tokenが空だと保存できないこと' do
        @purchase_destination.token = nil
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Token can't be blank")
      end

      it 'userが紐付いていないと保存できないこと' do
        @purchase_destination.user_id = nil
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("User can't be blank")
      end
      
      it 'itemが紐付いていないと保存できないこと' do
        @purchase_destination.item_id = nil
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end

