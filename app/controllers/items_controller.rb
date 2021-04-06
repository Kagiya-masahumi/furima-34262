class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end

  end

  private
  def item_params
    params.require(:items).permit(:name, :status_id, :category_id, :item_explain, :carry_date_id, :carry_area_id, :postage_id, :price, :image).merge(user_id: current_user.id)
  end
  
end
