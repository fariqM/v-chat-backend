class MainController < ApplicationController
    def index
        render json:{
            "message": "yo wassup!"
        }
    end
    
end
