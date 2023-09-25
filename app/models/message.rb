class Message < ApplicationRecord
  belongs_to :user
  validates :text, :photo, presence: true
end
