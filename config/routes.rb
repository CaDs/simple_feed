Rails.application.routes.draw do
  root to: 'posts#index'
  resources :sessions, only: %i[new create destroy]
  resources :posts
end
