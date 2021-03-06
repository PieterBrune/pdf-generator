Rails.application.routes.draw do
  get 'invoices/index'
  get 'invoices/show'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :invoices, only: %i[new create index show]
end
