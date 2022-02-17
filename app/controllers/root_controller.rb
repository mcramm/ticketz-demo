class RootController < ApplicationController
  def index
    @movies = Movie.all
    @showtimes = []
    @selected_tickets = load_selected_tickets
  end

  def showtimes
    movie_id = params.require(:movie_id)

    @showtimes = Showtime.where(movie_id: movie_id)

    respond_to do |format|
      format.turbo_stream
    end
  end

  def tickets
    showtime_id = params.require(:showtime_id)

    @tickets = Ticket.where(showtime_id: showtime_id)
      .joins(:seat)
      .includes(:seat)
      .order("seats.id ASC")

    respond_to do |format|
      format.turbo_stream
    end
  end

  def select_ticket
    ticket_id = params.require(:id)

    @ticket = Ticket.where(id: params.require(:id)).first!
    @ticket.update(status: :claimed_pending_payment)

    @selected_tickets = load_selected_tickets

    respond_to do |format|
      format.turbo_stream
    end
  end

  def deselect_ticket
    ticket_id = params.require(:id)

    @ticket = Ticket.where(id: params.require(:id)).first!
    @ticket.update(status: :available)

    @selected_tickets = load_selected_tickets

    respond_to do |format|
      format.turbo_stream
    end
  end

  private def load_selected_tickets
    tickets = Ticket.claimed_pending_payment
      .includes(:seat)
      .includes(showtime: [:movie, :theatre])

    tickets_by_movie = tickets.group_by { |ticket| ticket.showtime.movie.name }

    tickets_by_movie.map do |movie_name, tickets|
      [movie_name, tickets.group_by { |ticket| ticket.showtime.starts_at }]
    end.to_h
  end
end
