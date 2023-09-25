class MainController < ApplicationController
    def index
        message = Main.find_by(id: 1)
        render json:{
            "message": message['message']
        }
    end
end
