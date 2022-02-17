class RootController < ApplicationController
  def index
    @movies = Movie.all
    @showtimes = []
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

    respond_to do |format|
      format.turbo_stream
    end
  end

  def deselect_ticket
    ticket_id = params.require(:id)

    @ticket = Ticket.where(id: params.require(:id)).first!
    @ticket.update(status: :available)

    respond_to do |format|
      format.turbo_stream
    end
  end
end
