Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'sessions/new'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, format: 'json' do
    namespace :v1 do
      resources :users
      resources :messages
      resources :rooms
      resources :sessions
    end
  end
end
