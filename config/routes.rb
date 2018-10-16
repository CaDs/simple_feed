Rails.application.routes.draw do
  root to: 'posts#index'
  resources :sessions, only: %i[new create]
  delete 'sessions/destroy'
  resources :posts
  resources :users, only: %i[index new create]
  resources :connections, only: %i[create destroy]
end
