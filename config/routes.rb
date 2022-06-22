Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  resources :lists do
      resources :bookmarks, only: [:new, :create, :edit, :update, :destroy ]
    end
  resources :movies, only: [:index]
end
