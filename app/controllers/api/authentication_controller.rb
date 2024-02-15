class Api::AuthenticationController < ApplicationController
  def login
    @user = User.find_by(email: params[:user][:email])
    if @user&.valid_password?(params[:user][:password])
      token = create_token(@user.id)
      render json: {user: {email: @user.email, token: token, username: @user.name}}
    else
      render json: {errors: 'Unauthorized'}, status: :unauthorized
    end
  end
end