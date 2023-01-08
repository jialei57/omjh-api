Rails.application.routes.draw do
  
  mount ActionCable.server => "/cable"

  resources :users
  resources :characters
  resources :messages

  post 'authenticate', to: 'authentication#authenticate'

  get 'mobile-app-version', to: 'version#mobile_app_version'

  get 'map', to: 'download#download_map'
end 