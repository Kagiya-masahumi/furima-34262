class OrdersController < ApplicationController
  before_action :block_out_page, only:[:index, :create]

  def index
    @item = Item.find(params[:item_id])
    @order_address = OrderAddress.new
  end


  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_num, :prefecture, :city, :address, :building, :phone_num)
                                  .merge(user_id: current_user, item_id: current_user.item)
  end

  def block_out_page
    if @item.user != current_user
      redirect_to root_path
    end
  end


end
