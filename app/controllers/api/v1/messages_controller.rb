class Api::V1::MessagesController < ApplicationController
  def index
    messages = Message.order(created_at: :desc)
    render json: {
      'success': true,
      'messages': messages
    }, status: 200
  end

  def create
    email = params['email']
    token = params['token']

    begin
      decodeToken = JWT.decode(token, nil, false) # will throw an error if jwt invalid
      emailFromToken = decodeToken[0]['email']
      user = User.find_by(email: emailFromToken)
      if user
        if user['email'] == email
          newMessage = user.messages.create(message_params)
          if newMessage.invalid?
            render json: {
              'success': false,
              'msg': 'Invalid payload'
            }, status: 403
          else
            render json: {
              'success': true,
              'msg': 'Message has been sent'
            }, status: 201
          end
        else
          render json: {
            'success': false,
            'msg': 'Bad credential! (1)'
          }, status: 403
        end
      else
        render json: {
          'success': false,
          'msg': 'Bad credential ! (2)'
        }, status: 403
      end
    rescue => e
      render json: {
        'success': false,
        'msg': 'Invalid token!'
      }, status: 403
    end
  end

  private

  def message_params
    params.permit(:text, :user)
  end
end
