Rails.application.routes.draw do
  get 'pages/secret'

  get 'posts/confirm'
  post 'posts/confirm'
  get 'posts/confirmUpdate'
  post 'posts/search'
	patch 'posts/editConfirm' => 'posts#editConfirm'
  post 'posts/editConfirm'
  get 'posts/update'
  post 'posts/update'
  get 'posts/destroy' => 'posts#destroy'
	post 'posts/destroy' => 'posts#destroy'
  post 'posts/import'
  get 'posts/export' => 'posts#export'

  get 'users/profile'
  get 'users/editProfile'
  get 'users/changePassword'
  get 'users/editProfile'
 post 'users/updateProfile'
 post 'users/updatePassword'
 get 'users/registerConfirm'
 post 'users/registerConfirm'
  
  get 'sessions/new'
  get 'sessions/authenticate'
  post 'sessions/authenticate'
  get 'sessions/signup'
	get 'sessions/destroy'  

  root 'sessions#new'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :posts
  resources :users

  # Defines the root path route ("/")
  # root "articles#index"
end
