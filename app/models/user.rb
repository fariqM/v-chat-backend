class User < ApplicationRecord
    validates :username, :password, :password_confirmation, presence: true
    validates :password, confirmation: true
end
