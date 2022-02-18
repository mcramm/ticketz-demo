class RootController < ApplicationController
  before_action :set_current_customer

  def index
    @movies = Movie.all
    @showtimes = []
    @purchase_preview = load_purchase_preview
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

    if @ticket.claimed_pending_payment? && @ticket.customer != @current_customer
      respond_to do |format|
        format.turbo_stream { render template: "select_ticket_conflict" }
      end
      return
    end

    @ticket.update(status: :claimed_pending_payment, customer: @current_customer)

    @purchase_preview = load_purchase_preview

    respond_to do |format|
      format.turbo_stream
    end
  end

  def deselect_ticket
    ticket_id = params.require(:id)

    @ticket = Ticket.where(id: params.require(:id)).first!
    @ticket.update(status: :available, customer: nil)

    @purchase_preview = load_purchase_preview

    respond_to do |format|
      format.turbo_stream
    end
  end

  private def load_purchase_preview
    tickets = Ticket.claimed_pending_payment
      .where(customer: @current_customer)
      .includes(:seat)
      .includes(showtime: [:movie, :theatre])

    PurchasePreviewPresenter.new(tickets)
  end
end
