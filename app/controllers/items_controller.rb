class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
  end

  private
  def item_params
    params.require(:items).permit(:name, :status_id, :category_id, :item_explain, :carry_date_id, :carry_area_id, :postage_id, :price, :image).merge(user_id: current_user.id)
  end
  
end
