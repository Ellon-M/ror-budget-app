Rails.application.routes.draw do
  get 'payments/index'
  get 'payments/new'
  get 'payments/create'
  get 'payments/destroy'
  devise_for :users
  root to: "splash#index"
  resources :payments, only: [:index, :new, :create, :destroy]
end
