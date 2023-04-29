Rails.application.routes.draw do
  get 'category/index'
  get 'category/new'
  get 'category/create'
  get 'category/destroy'
  get 'payments/index'
  get 'payments/new'
  get 'payments/create'
  get 'payments/destroy'
  devise_for :users
  root to: "splash#index"
  resources :payments, only: [:index, :new, :create, :destroy]
  resources :categories, only: [:index, :new, :show, :create, :destroy]
end
