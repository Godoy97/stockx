Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  post "/orders/:id/status", to: "orders#status", as: :status

  resources :products do
    resources :orders, only: [:new, :create]

  end
  resources :orders, only: [:index, :show, :edit, :update]


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
