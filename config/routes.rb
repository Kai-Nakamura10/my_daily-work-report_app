Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
  root "homes#index"
  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get    'signup', to: 'users#new'
  post   'signup', to: 'users#create'
  resources :reports
end
