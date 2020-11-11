Rails.application.routes.draw do
  
  devise_for :users
  root to: "prototypes#index"
          # ↓なぜ複数形なのか？ A.resourcesだから(resourceならテーブル名は単数形)
  resources :users, only: :show
  resources :prototypes do
    resources :comments, only: :create
  end
end
