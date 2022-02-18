class RootController < ApplicationController
  before_action :set_current_customer

  def index
    @movies = Movie.all
    @showtimes = []
    @selected_tickets = load_selected_tickets
  end

  def showtimes
    movie_id = params[:movie_id]

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
    @ticket.update(status: :claimed_pending_payment, customer: @current_customer)

    @selected_tickets = load_selected_tickets

    respond_to do |format|
      format.turbo_stream
    end
  end

  def deselect_ticket
    ticket_id = params.require(:id)

    @ticket = Ticket.where(id: params.require(:id)).first!
    @ticket.update(status: :available, customer: nil)

    @selected_tickets = load_selected_tickets

    respond_to do |format|
      format.turbo_stream
    end
  end

  private def load_selected_tickets
    tickets = Ticket.claimed_pending_payment
      .where(customer: @current_customer)
      .includes(:seat)
      .includes(showtime: [:movie, :theatre])

    SelectedTicketsPresenter.new(tickets)
  end
end
