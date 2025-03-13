Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    namespace :v1 do
      resources :users, only: [:show, :create]
      resources :wallets, only: [:show, :create]
      resource :session, only: [:create, :destroy]  # Sessions
      get "/stocks", to: "stocks#new"

      # RESTful routes for each transaction type
      namespace :transactions do
        resources :deposits, only: [:create]    # POST /api/v1/transactions/deposits
        resources :withdrawals, only: [:create] # POST /api/v1/transactions/withdrawals
        resources :transfers, only: [:create]   # POST /api/v1/transactions/transfers
      end
    end
  end
end
