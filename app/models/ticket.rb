class Ticket < ApplicationRecord
  belongs_to :seat
  belongs_to :showtime
  belongs_to :customer, optional: true

  enum status: {
    available: 0,
    claimed_pending_payment: 1,
    claimed: 2,
  }

  def cost
    seat.base_cost_cents + price_cents
  end
end
