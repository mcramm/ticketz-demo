Rails.application.routes.draw do
  get 'sessions/new'
  post 'sessions/create'
  delete 'sessions/delete'

  root "root#index"

  get "root/index"

  post "root/showtimes"
  post "root/tickets"
  post "root/select_ticket/:id", to: "root#select_ticket"
  post "root/deselect_ticket/:id", to: "root#deselect_ticket"
end
