Rails.application.routes.draw do
  resources :data_sources
  resources :golfers, only: :index
end
