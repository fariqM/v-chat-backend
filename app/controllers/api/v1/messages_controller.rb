class Api::V1::MessagesController < ApplicationController
  def index
    messages = Message.order(created_at: :desc)
    render json: {
      'success': true,
      'messages': messages
    }, status: 200
  end

  def create
    
  end
  
end
