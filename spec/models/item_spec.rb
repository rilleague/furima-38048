require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品を出品出来る場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@item).to be_valid
      end
    end

    context '商品を出品出来ない場合' do
      it 'imageが空では保存出来ない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'nameが空では保存出来ない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it 'contentが空では保存出来ない' do
        @item.content = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Content can't be blank")
      end

      it 'category_idが空では保存出来ない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end

      it 'condition_idが空では保存出来ない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition must be other than 1')
      end

      it 'shipping_cost_idが空では保存出来ない' do
        @item.shipping_cost_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping cost must be other than 1')
      end

      it 'prefecture_idが空では保存出来ない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture must be other than 1')
      end

      it 'shipping_day_idが空では保存出来ない' do
        @item.shipping_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping day must be other than 1')
      end

      it 'selling_priceが空では保存出来ない' do
        @item.selling_price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Selling price can't be blank", 'Selling price is invalid')
      end

      it 'selling_priceが全角数字では保存出来ない' do
        @item.selling_price = '２０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price is not a number')
      end

      it 'selling_priceが300円未満では保存出来ない' do
        @item.selling_price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price must be greater than or equal to 300')
      end

      it 'selling_priceが1,000万円以上だと保存出来ない' do
        @item.selling_price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include('Selling price must be less than or equal to 9999999')
      end

      it 'userが紐づいていないと保存出来ない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
