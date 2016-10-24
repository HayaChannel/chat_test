class Api::V1::RoomsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @rooms = Room.all
    render json: @rooms
  end

  def create
    room = Room.new(create_params)
    # エラー処理
    unless room.save # もし、roomが保存できなかったら
      @error_message = [room.errors.full_messages].compact # エラーが入ってるインスタンス変数を定義
    end
  end


  private
  def create_params
    params.permit(:name)
  end


end