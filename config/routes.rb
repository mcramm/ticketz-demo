Rails.application.routes.draw do
  root "root#index"

  get "root/index"

  post "root/showtimes"
  post "root/tickets"
  post "root/select-ticket"
end
