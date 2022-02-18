class ApplicationController < ActionController::Base
  def set_current_customer
    @current_customer ||= begin
      current_customer_id = session[:current_customer_id]

      # if session[:current_customer_id] is nil, then this will also return nil
      current_customer = Customer.where(id: current_customer_id).first

      if current_customer.blank?
        session[:return_to] = request.path
        redirect_to sessions_new_path
      end

      current_customer
    end
  end
end
