Rails.application.routes.draw do
  resources :projects do
    resources :questions, only: %i[create new]
  end

  resources :questions, only: %i[show edit update destroy] do
    resources :feedbacks, only: %i[create new]
  end

  namespace :users do
    resources :projects, only: %i[show index]
  end
  devise_for :users
  root to: 'projects#index' 
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :checkpoints, only: %i[create show index]
    end
  end 
end
