class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @items = Item.all.order(id: "DESC")
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
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    if @item.user != current_user
      redirect_to item_path
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(item_params)
    else
      render :edit
    end

  end



  private
  def item_params
    params.require(:item)
          .permit(:name,
                  :status_id,
                  :category_id, 
                  :explain, 
                  :carry_date_id, 
                  :carry_area_id, 
                  :postage_id, 
                  :price, 
                  :image)
          .merge(user_id: current_user.id)
  end

end
