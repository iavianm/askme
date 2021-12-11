Rails.application.routes.draw do
  resources :hashtags
  root 'users#index'

  resources :users
  resources :sessions, only: %i[new create destroy]
  resources :questions, except: %i[show new index]
  resources :hashtags, only: [:show]

  get 'sign_up' => 'users#new'
  get 'log_out' => 'sessions#destroy'
  get 'log_in' => 'sessions#new'
end
