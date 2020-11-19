Rails.application.routes.draw do
  resources :reports do
    resources :comments, controller: "reports/comments"
  end
  resources :books do
    resources :comments, controller: "books/comments"
  end

  root 'books#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  devise_scope :user do
    get 'sign_in', to: 'users/sessions#new'
    get 'sign_out', to: 'users/sessions#destroy'
  end

  resources :users do
    resource :user_relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end
end
