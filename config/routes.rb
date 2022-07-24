Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "posts#index"
  
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only:[:new, :create, :edit, :update]
  resource :session, only:[:new, :create, :destroy]


  get("users/:id/edit/pass_edit", {to: 'users#pass_edit', as: 'pass_edit'})
  patch("users/:id/edit/pass_edit/pass_update", {to: 'users#pass_update', as: 'pass_update'})
  
end
