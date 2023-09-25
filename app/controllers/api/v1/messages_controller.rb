class Api::V1::MessagesController < ApplicationController
  def index
    messages = Message.joins(:user).select('messages.*, users.username as username')
    render json: {
      'success': true,
      'messages': messages
    }, status: 200
  end

  def create
    email = params['email']
    token = params['token']
    # img_url = params['photo']

    # setup pusher
    Pusher.app_id = '1675826'
    Pusher.key = '30108b7620bbf32d2852'
    Pusher.secret = '1673537dae0e63a45d6c'
    Pusher.cluster = 'ap1'

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
            Pusher.trigger('v-chat', 'chat-message', { message: newMessage, username: user['username'] })
            render json: {
              'success': true,
              'msg': 'Message has been sent',
              'callback': newMessage
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
    rescue StandardError
      render json: {
        'success': false,
        'msg': 'Invalid token!'
      }, status: 403
    end
  end

  private

  def message_params
    params.permit(:text, :photo, :user)
  end
end
