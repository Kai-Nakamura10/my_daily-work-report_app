Rails.application.routes.draw do
  root "homes#top"
  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  resources :users, only: %i[new create]
  resources :reports, only: %i[index new create edit update show destroy]
end
