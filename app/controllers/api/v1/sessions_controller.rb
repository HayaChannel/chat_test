class Api::V1::SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      @user.activate
      render json: @user, notice: 'Logged in'
    else
      #flash.now[:alert] = 'Failed to login'
      #render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.inactivate
    logout
    render json: @user, notice: 'Logged out!'
  end
end
