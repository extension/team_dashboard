Rails.application.routes.draw do
  resources :responses do
    collection { post :import}
  end
  resources :submissions
  resources :surveys
  resources :teams
  root to: "home#index"
end
