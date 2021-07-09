class UsersController < ApplicationController

  def index
  end


  def new
    @user = User.new
  end

  def show
    user = User.find(params[:id])
    @nickname = user.nickname
    @items = user.items
  end



end
