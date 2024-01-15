# frozen_string_literal: true

Rails.application.routes.draw do
  resources :grids, except: %i[update edit] do
    collection do
      post :import
      get :random_new
    end
  end

  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'grids#index'
end
