class Api::V1::UsersController < ApplicationController
  def register
    user = User.new(user_params)
    if User.exists?(email: [params['email']])
      # update username
      newUsername = User.find_by(email: params['email'])
      newUsername.username = params['username']
      newUsername.save
      render json: {
        "success": true,
        "msg": 'Registration successful! User data has been updated.',
        "email":  user['email']
      }, status: 200
    elsif user.invalid?
      render json: {
        "success": false,
        "errors": user.errors,
        "msg": 'Registration cancelled, invalid payload!'
      }, status: 422
    else
      # create new one
      user.save
      render json: {
        "success": true,
        "msg": 'Registration successful!',
        "email":  user['email']
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
    params.permit(:email, :username)
  end
end
