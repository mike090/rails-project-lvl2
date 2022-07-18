# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users

  resources :posts do
    resources :comments, only: :create, module: :posts
    resources :likes, only: %i[create destroy], module: :posts
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
