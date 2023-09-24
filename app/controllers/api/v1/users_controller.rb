class Api::V1::UsersController < ApplicationController
  def index
    users = User.all
    render json: {
      'success': true,
      'data': users
    }, status: 200
  end
end
