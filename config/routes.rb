# frozen_string_literal: true

Rails.application.routes.draw do
  resource :users, path: 'user'

  resources :sessions, except: %i[show edit update] do
    delete '', action: :destroy, as: 'logout', on: :collection
  end

  root 'home#index'
end
