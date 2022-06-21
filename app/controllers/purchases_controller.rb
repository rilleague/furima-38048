class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: :index
  before_action :set_purchase, only: [:index, :create]

  def index
    @purchase_destination = PurchaseDestination.new
    if @item.user_id != current_user.id  
      if @item.purchase
        redirect_to root_path
      else
        render :index
      end
    else
      redirect_to root_path
    end
  end

  def create
    @purchase_destination = PurchaseDestination.new(purchase_params)
    if @purchase_destination.valid?
      pay_item
      @purchase_destination.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.require(:purchase_destination).permit(:post_code, :prefecture_id, :city, :street, :building, :phone).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.selling_price,
        card: purchase_params[:token],    
        currency: 'jpy'                 
      )
  end

  def set_purchase
    @item = Item.find(params[:item_id])
  end
end