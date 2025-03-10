Rails.application.routes.draw do
  devise_for :users, controllers: {
  omniauth_callbacks: "users/omniauth_callbacks",
  registrations: "registrations"
}


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  root to: "pages#index"

  devise_scope :user do
    get "login", to: "devise/sessions#new"
  end

  devise_scope :user do
    get "signup", to: "devise/registrations#new"
  end

  resources :posts do
    collection do
      get "hobby"
      get "study"
      get "team"
    end
  end

  namespace :private do
    resources :conversations, only: [ :index, :show, :create ] do
      member do
        post :close
        post :open
      end
    end
    resources :messages, only: [ :index, :create ]
  end

  namespace :group do
    resources :conversations do
      member do
        post :close
        post :open
      end
    end
    resources :messages, only: [:index, :create]
  end
end