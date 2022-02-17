class Theatre < ApplicationRecord
  has_many :seats, dependent: :destroy
  has_many :showtimes, dependent: :destroy
  has_many :movies, through: :showtimes

  validates :name, uniqueness: true
end
