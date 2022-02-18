class PurchasePreviewPresenter
  def initialize(selected_tickets)
    @selected_tickets = selected_tickets.map do |selected_ticket|
      SelectedTicketPresenter.new(selected_ticket)
    end
  end

  def empty?
    @selected_tickets.empty?
  end

  def tickets_by_movie
    # Yuck!
    @by_movie ||= @selected_tickets.group_by(&:movie_name)
      .map do |movie_name, tickets|
        by_showtime = tickets.group_by(&:showtime)
        [movie_name, by_showtime]
      end.to_h
  end

  def subtotal
    @subtotal ||= @selected_tickets.reduce(0) do |sum, ticket|
      sum += ticket.price
    end
  end

  def taxes
    @taxes ||= subtotal * (tax_percentage.to_f / 100)
  end

  def tax_percentage
    # Hardcoding for now...
    5
  end

  def total
    @total ||= subtotal + taxes
  end
end
