class Api::V1::TokenController < ApplicationController
  def register
    user = User.find_by(email: params['email'])
    if user # check if the user exist
      begin
        decodeToken = JWT.decode(params['token'], nil, false) # will throw an error if jwt invalid

        if params['email'] == decodeToken[0]['email'] # check if the given jwt is same with email
          newTOken = user.api_tokens.create(token_params)
          if newTOken.invalid?
            # return false if payload invalid
            render json: {
              'success': false,
              'msg': 'Invalid payload!'
            }, status: 403
          else
            render json: {
              'success': true,
              'msg': 'Token created!',
              'email': user['email'], 
              'username': user['username'], 
            }, status: 201
          end
        else
          render json: {
            'success': false,
            'msg': 'Invalid tokens!',
            'param': params['email'],
            'data': decodeToken[0]['email']
          }, status: 403
        end
      rescue StandardError
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
