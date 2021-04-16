class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index

    @item = Item.find(params[:item_id])

    @order_address = OrderAddress.new
  end


  def create
    @item = Item.find(params[:item_id])
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
                                  .merge(user_id: current_user, item_id: params[:item_id])
  end



end
