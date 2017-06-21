Rails.application.routes.draw do
  get 'searches/show'

  root 'pages#home'

  get 'log_in' => "sessions#new"
  post 'log_in' => "sessions#create"
  delete 'log_out' => "sessions#destroy"
  get 'sign_up' => "users#new"

  resources :users
  resource :search, only: :show

  resources :conversations, only: [:create, :index, :show] do
    resources :messages, only: [:create, :index]
  end

end
