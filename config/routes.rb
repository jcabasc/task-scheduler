Rails.application.routes.draw do
  resources :tasks
  resource :sessions
  resources :logs, only: :index
end