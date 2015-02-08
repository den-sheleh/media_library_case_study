Rails.application.routes.draw do
  devise_for :users

  root to: 'media_items#index'

  resources :media_items do
    resources :images, only: [:index, :create, :destroy]
  end

  resources :libraries, only: :show do
    get :share, on: :collection
    get :hide, on: :collection
  end
end
