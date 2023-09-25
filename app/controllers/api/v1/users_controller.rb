class Api::V1::UsersController < ApplicationController
  def register
    render json: {
      'msg': 'Here you go, your login payload',
      'payload': params
    }
    # user = User.new(user_params)

    # if user.invalid?
    #   render json: {
    #     "success": false,
    #     "errors": user.errors,
    #     "msg": 'Registration cancelled, please check the column.'
    #   }, status: 422
    # elsif User.exists?(email: [params['email']])
    #   # update username
    #   newUsername = User.find_by(email: params['email'])
    #   newUsername.username = params['username']
    #   newUsername.save
    #   render json: {
    #     "success": true,
    #     "msg": 'Registration successful!'
    #   }, status: 201
    # else
    #   # create new one
    #   user.save
    #   render json: {
    #     "success": true,
    #     "msg": 'Registration successful!'
    #   }, s
    # end
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

  def token_params
    params.permit(:token)
  end
end
