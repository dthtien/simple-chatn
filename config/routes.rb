Rails.application.routes.draw do
  root 'pages#home'

  get 'log_in' => "sessions#new"
  post 'log_in' => "sessions#create"
  delete 'log_out' => "sessions#destroy"
  get 'sign_up' => "users#new"

  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
