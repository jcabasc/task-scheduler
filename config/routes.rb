Rails.application.routes.draw do
  resources :tasks
  resources :logs, only: :index
  get  'sign_in',  to: 'sessions#new'
  post 'sign_in',  to: 'sessions#create'
end