Rails.application.routes.draw do
  
  mount ActionCable.server => "/cable"

  resources :users
  resources :characters
  resources :messages

  get 'processing-quests/:id', to: 'characters#get_processing_quests'
  get 'items/:id', to: 'characters#get_items'
  get 'npc-skills/:id', to: 'api#get_npc_skills'
  put 'complete-quest', to: 'characters#complete_quest'
  put 'killed-npc', to: 'characters#killed_npc'

  post 'authenticate', to: 'authentication#authenticate'

  get 'mobile-app-version', to: 'version#mobile_app_version'

  get 'map', to: 'download#download_map'
end 