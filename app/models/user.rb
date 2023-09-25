class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates :username, presence: true

  has_many :api_tokens
end
