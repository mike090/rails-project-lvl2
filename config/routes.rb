# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users

  resources :posts, only: %i[index new create show] do
    scope module: :posts do
      resources :comments, only: :create
      resources :likes, only: %i[create destroy]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
