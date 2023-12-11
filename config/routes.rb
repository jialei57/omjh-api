Rails.application.routes.draw do
  
  mount ActionCable.server => "/cable"

  resources :users
  resources :characters
  resources :messages

  get 'processing-quests/:id', to: 'characters#get_processing_quests'
  get 'items/:id', to: 'characters#get_items'
  get 'npc-related/:id', to: 'api#get_npc_related'
  put 'complete-quest', to: 'characters#complete_quest'
  put 'equip', to: 'characters#equip'
  put 'take_off', to: 'characters#take_off'
  put 'accept-quest', to: 'characters#accept_quest'
  put 'killed-npc', to: 'characters#killed_npc'

  post 'authenticate', to: 'authentication#authenticate'

  get 'mobile-app-version', to: 'version#mobile_app_version'
  get 'map-version', to: 'version#map_version'

  get 'map', to: 'download#download_map'
end 