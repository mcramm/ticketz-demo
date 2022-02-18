class SelectedTicketPresenter
  include ActionView::Helpers::NumberHelper

  def initialize(selected_ticket)
    @selected_ticket = selected_ticket
  end

  def id
    @selected_ticket.id
  end

  def movie_name
    @selected_ticket.showtime.movie.name
  end

  def showtime
    @selected_ticket.showtime.starts_at.to_fs(:showtime_full)
  end

  def seat_number
    @selected_ticket.seat.number
  end

  def theatre_name
    @selected_ticket.seat.theatre.name
  end

  def price
    @price ||= Money.from_cents(@selected_ticket.price, "CAD")
  end
end
