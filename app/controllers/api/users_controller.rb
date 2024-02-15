class Api::UsersController < ApplicationController
  before_action :authenticate

  def show
    @user = User.find_by(id: params[:id])
    render json: {user: {id: @user.id, name: @user.name, email: @user.email}}
  end

  def user_params
    params.require(:user).permit(:id)
  end
end