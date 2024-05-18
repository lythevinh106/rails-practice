Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  namespace :admin do
    resources :product_orders
    resources :orders do
      collection do
        get 'measure', to: 'orders#measure'
      end
    end
    resources :categories
    resources :products
  end
  get "admin" => "admin/products#index", turbo_link: false
  # root to: "admin#index"
  # get "admin" => "admin#index"
  root 'pages#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
