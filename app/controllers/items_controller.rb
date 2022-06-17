class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :destory]
  before_action :set_item, only:[:show, :edit, :update, :destory]
  before_action :move_to_index, only: [:edit, :destory]

  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :content, :image, :category_id, :condition_id, :shipping_cost_id, :prefecture_id,
                                 :shipping_day_id, :selling_price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    unless @item.user_id == current_user.id
      redirect_to action: :index
    end
  end
end
