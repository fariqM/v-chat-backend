class Message < ApplicationRecord
  belongs_to :users
  validates :user_id, :text, presence: true
end
