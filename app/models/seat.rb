class Seat < ApplicationRecord
  belongs_to :theatre
  has_many :tickets, dependent: :destroy
end
