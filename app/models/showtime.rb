class Showtime < ApplicationRecord
  belongs_to :theatre
  belongs_to :movie
  has_many :tickets, dependent: :destroy

  validates :starts_at, uniqueness: {
    scope: :theatre, 
    message: "There can only be one showtime starting at the same time in a theatre!"
  }
end
