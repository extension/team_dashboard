Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    get 'admin', to: 'users/sessions#new', as: :new_user_session
    # get 'users/sign_in', to: 'users/sessions#new', as: :session
    get 'users/sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
  end
  resources :responses do
    collection { post :import}
  end
  resources :submissions
  resources :surveys
  resources :teams
  get 'upload', to: 'home#upload'
  root to: "home#index"
end
