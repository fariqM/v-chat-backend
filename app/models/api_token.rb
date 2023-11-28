class ApiToken < ApplicationRecord
  belongs_to :user
  validates :token, presence: true, uniqueness: false
end
