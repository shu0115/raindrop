Raindrop::Application.routes.draw do
  resources :projects do
    resources :tickets do
      member do
        post 'status_update'
      end
    end
  end

  root to: 'top#index'

  # For OmniAuth
  get "/auth/:provider/callback" => "sessions#callback"
  get "/auth/failure"            => "sessions#failure"
  get "/logout"                  => "sessions#destroy", as: :logout
end
