class Customer < ApplicationRecord
  has_one :ticket, dependent: :destroy

  validates :name, uniqueness: true
end
