Rails.application.routes.draw do
  resources :projects do
    resources :questions, only: [:create]
    resources :feedbacks, only: [:create]
  end
  resources :questions, only: %i[show edit update destroy]

  namespace :users do
    resources :projects, only: %i[show index]
  end
  devise_for :users
  root to: 'projects#index' 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
