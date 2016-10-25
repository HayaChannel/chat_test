class Api::V1::SessionsController < ApplicationController
  skip_before_filter :require_valid_token, only: :create

  #def new
   # @user = User.new
  #end

  def create
    if @user = login(login_user[:username], login_user[:password])
      session = @user.activate
      @access_token = session.access_token
      render json: @access_token, notice: 'Logged in'
    else
      #flash.now[:alert] = 'Failed to login'
      #render :new
    end
  end

  def destroy
    access_token = request.headers[:HTTP_ACCESS_TOKEN]
    session = Session.find_by_access_token(access_token)
    if session
      user = User.find(session.user_id)
      user.inactivate
      logout
      render json: @user, notice: 'Logged out!'
    end
  end

  private

  def login_user
    params[:user]
  end
end
