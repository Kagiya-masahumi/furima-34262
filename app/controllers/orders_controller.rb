class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_item, only:[:index, :create]
  before_action :block_out_page
  


  def index
    @order_address = OrderAddress.new
  end


  def create
    @order_address = OrderAddress.new(order_params)

    if @order_address.valid?
      pay_item
      @order_address.save!
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_num, :prefecture, :city, :address, :building, :phone_num, :token)
                                  .merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: order_params[:token],
        currency: 'jpy'
      )
  end

  def block_out_page
    if @item.user_id == current_user.id || @item.order.present?
      redirect_to root_path
    end
  end

    def find_item
      @item = Item.find(params[:item_id])
    end

end
