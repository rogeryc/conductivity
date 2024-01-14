Rails.application.routes.draw do
  resources :grids, except: %i[update edit]

  get "up" => "rails/health#show", as: :rails_health_check

  root "grids#index"
end
