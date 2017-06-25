Rails.application.routes.draw do
  get 'searches/show'

  root 'pages#home'

  get 'log_in' => "sessions#new"
  post 'log_in' => "sessions#create"
  delete 'log_out' => "sessions#destroy"
  get 'sign_up' => "users#new"

  resources :users
  resource :search, only: :show

  resources :conversations, only: [:create, :show, :index] do
    resources :messages, only: [:create]
  end

  post "add_friend", to: "friendships#add_friend"
  post "unfriend", to: "friendships#unfriend"
  post "block", to: "friendships#block"
  post "unblock", to: "friendships#unblock"

end
