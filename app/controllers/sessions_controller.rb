class SessionsController < ApplicationController
  def new
  end

  def create
    # You get the idea...
    customer = Customer.find_or_create_by!(name: params.require(:name))

    session[:current_customer_id] = customer.id

    redirect_to(session.fetch(:return_to, root_url))
  end

  def delete
    session.delete(:current_customer_id)
    redirect_to(sessions_new_path)
  end
end
