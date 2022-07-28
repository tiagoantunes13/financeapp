Rails.application.routes.draw do
  resources :user_stocks

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "welcome#index"
  devise_for :users
  get "my_portfolio", to: 'users#my_portfolio'
  post 'search_stock', to: 'stocks#search'#, defaults: { format: :turbo_stream }
end
