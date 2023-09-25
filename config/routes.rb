Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/', to: 'main#index'
  namespace :api do
    namespace :v1 do
      resources :messages
      post 'register', to: 'users#register'
      post 'register-token', to: 'token#register'
      post 'login', to: 'users#login' 
    end
  end
end
