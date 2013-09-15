Raindrop::Application.routes.draw do
  resources :tickets do
    member do
      post 'status_update'
    end
  end
  resources :projects

  root to: 'top#index'

  # For OmniAuth
  get "/auth/:provider/callback" => "sessions#callback"
  get "/auth/failure"            => "sessions#failure"
  get "/logout"                  => "sessions#destroy", as: :logout
end
