class Api::V1::UsersController < ApplicationController
  def register
    user = User.new(user_params)

    if user.invalid?
      render json: {
        "success": false,
        "errors": user.errors
      }, status: 422
    elsif User.exists?(username: [params['username']])
      render json: {
        "success": false,
        "msg": 'Username is not available'
      }, status: 403
    else
      user.save
      render json: {
        "success": true,
        "msg": 'Registration successful!'
      }, status: 201
    end
  end

  def login
    render json: {
      'msg': 'Here you go, your login payload',
      'payload': params
    }
  end

  private

  def user_params
    params.permit(:username, :password, :password_confirmation)
  end
end
