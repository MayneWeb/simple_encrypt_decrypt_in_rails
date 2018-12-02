Rails.application.routes.draw do
  devise_for :users
  root to: 'users#index'

  patch '/save', to: 'users#save_keys', as: 'save_keys'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
