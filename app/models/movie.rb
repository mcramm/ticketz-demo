class Movie < ApplicationRecord
  has_many :showtimes, dependent: :destroy
  has_many :theatres, -> { distinct }, through: :showtimes

  validates :name, uniqueness: true
end
