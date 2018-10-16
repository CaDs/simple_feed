Rails.application.routes.draw do
  resources :sessions, only: %i[new create destroy]
  root to: 'posts#index'
  resources :posts
end
