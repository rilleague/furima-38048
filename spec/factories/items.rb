FactoryBot.define do
  factory :item do
    name              { 'テストサンプル' }
    content           { 'お買い求め下さい' }
    category_id       { 2 }
    condition_id      { 2 }
    shipping_cost_id  { 2 }
    prefecture_id     { 2 }
    shipping_day_id   { 2 }
    selling_price     { 2000 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/item-image.png'), filename: 'item-image.png')
    end
  end
end
