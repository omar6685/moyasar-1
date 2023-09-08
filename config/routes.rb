Rails.application.routes.draw do
  root 'static_public#home'
  devise_for :users
  
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :payments
  get 'user_dash', to: 'static_public#user_dash'
  get 'trems', to: 'static_public#trems'
  get 'payment_status', to: 'payments#payment_status'
  get 'pricing', to: 'static_public#pricing'
  resources :products
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
