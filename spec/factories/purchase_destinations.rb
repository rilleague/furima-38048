FactoryBot.define do
  factory :purchase_destination do
    post_code     { '123-4567' }
    prefecture_id { 2 }
    city          { '横浜市緑区' }
    street        { '青山1-1-1' }
    building      { '柳ビル' }
    phone         { '09012345678' }
    token         { 'tok_abcdefghijk00000000000000000' }
  end
end
