class Api::V1::TokenController < ApplicationController
  def register
    user = User.find_by(email: params['email'])
    if user
      begin
        decodeToken = JWT.decode(params['token'], nil, false)
        newTOken = user.api_tokens.create(token_params)
        if newTOken.invalid?
          render json: {
            'success': false,
            'msg': 'Invalid payload!'
          }, status: 403
        else
          render json: {
            'success': true,
            'msg': 'Token created!',
            'email': user['email'],
            'username': user['username']
          }, status: 201
        end
      rescue 
        render json: {
          'success': false,
          'msg': 'Invalid token!'
        }, status: 403
      end

    else
      render json: {
        'success': false,
        'msg': 'User not found'
      }, status: 404
    end
  end

  private

  def token_params
    params.permit(:token, :user)
  end
end
