# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :merchants, except: :create

  namespace :api, defaults: { format: %i[json xml] } do
    namespace :v1 do
      resources :sessions, only: %i[create destroy]
      resources :transactions, only: %i[create destroy]
    end
  end
end
