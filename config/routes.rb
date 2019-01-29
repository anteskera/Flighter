Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  get '/world-cup', to: 'world_cups#new'
  namespace :api do
    resources :bookings, except: [:new, :edit]
    resources :companies, except: [:new, :edit]
    resources :flights, except: [:new, :edit]
    resources :users, except: [:new, :edit]
  end
end
