Rails.application.routes.draw do
  devise_for :users

  root to: 'media_items#index'
end
