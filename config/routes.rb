Rails.application.routes.draw do
  get 'static_public/home'
  get 'static_public/user_dash'
  get 'static_public/trems'
  resources :products
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
