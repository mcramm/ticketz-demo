class Movie < ApplicationRecord
  has_many :showtimes, dependent: :destroy
  has_many :theatres, -> { distinct }, through: :showtimes
  has_many :tickets, through: :showtimes

  validates :name, uniqueness: true
end
