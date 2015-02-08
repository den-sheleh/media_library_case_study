Rails.application.routes.draw do
  devise_for :users

  root to: 'media_items#index'

  resources :media_items, only: [:index, :new, :create] do
    resources :images
  end
end
