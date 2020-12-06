Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
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
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :checkpoints, only: %i[create show index]
    end
  end 
end
