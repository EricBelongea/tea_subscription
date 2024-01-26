Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :subscriptions, only: [:create, :update]
      resources :customers, only: [:index] do
        resources :subscriptions, only: :show
      end
    end
  end
end
