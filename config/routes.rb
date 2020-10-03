Rails.application.routes.draw do
  get 'users/show'
  resources :books
  root 'books#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  get 'users/show' => 'users#show'
  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    get 'sign_out', to: 'users/sessions#destroy'
  end
end
