class PurchaseDestination
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :street, :building, :phone, :user_id, :item_id, :token

  with_options presence: true do
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/}
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :city
    validates :street
    validates :phone, format: { with: /\A\d{10,11}\z/ }
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Destination.create(post_code: post_code, prefecture_id: prefecture_id, city: city, street: street, building: building, phone: phone, purchase_id: purchase.id)
  end
end