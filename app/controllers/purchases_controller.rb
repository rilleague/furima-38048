class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: :index
  def index
    @purchase_destination = PurchaseDestination.new
    @item = Item.find(params[:item_id])
    if user_signed_in?
      if @item.user_id != current_user.id  
        if @item.purchase
          redirect_to root_path
        else
          render :index
        end
      else
        redirect_to root_path
      end
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @purchase_destination = PurchaseDestination.new(purchase_params)
    @item = Item.find(params[:item_id])
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
end