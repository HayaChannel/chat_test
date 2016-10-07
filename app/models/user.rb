class User < ApplicationRecord
  has_many :me_logings
  has_many :rooms, through: :me_logings
  has_many :messages
end
