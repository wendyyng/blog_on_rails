Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"
  
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  resources :users 
  resource :session, only:[:new, :create, :destroy]

  get '/account_details' => 'users#edit'
  get '/change_password', to: 'users#change_password', as: :change_password
  post '/update_password', to: 'users#update_password', as: :update_password

end
