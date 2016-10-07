class Room < ApplicationRecord
  has_mamy :me_logings
  has_many :users, through: :me_logings
  has_many :messages
end
