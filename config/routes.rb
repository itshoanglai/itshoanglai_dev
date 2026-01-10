Rails.application.routes.draw do
  root 'authentication#new_session'

  get '/login', to: 'authentication#new_session'
  post '/login', to: 'authentication#create_session'
  get '/register', to: 'authentication#new_registration'
  post '/register', to: 'authentication#create_registration'
  delete '/logout', to: 'authentication#destroy_session'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest

  # Defines the root path route ('/')
  # root 'posts#index'
end
