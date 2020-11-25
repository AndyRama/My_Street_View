Rails.application.routes.draw do
  resources :projects do
    resources :questions, only: %i[create new]
  end

  resources :questions, only: %i[show edit update destroy] do
    resources :feedbacks, only: %i[show]
  end

  namespace :users do
    resources :projects, only: %i[show index]
    resources :questions, only: [:show] do
      resources :feedbacks, only: %i[new create]
    end
  end
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root to: 'projects#index' 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
