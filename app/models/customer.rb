class Customer < ApplicationRecord
  has_many :tickets

  validates :name, uniqueness: true
end
