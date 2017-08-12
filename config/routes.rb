Rails.application.routes.draw do


  get 'students/index'

  get 'students/show'

  get 'users/index'

  get 'users/show'

  get 'users/new'

  devise_for :users
  resources :classifications
  resources :careers
  resources :students
  post 'students/index'

  get 'index/home'
  post 'index/home'
  get 'index/test'
  post 'index/test'
  get 'index/info'
  post 'index/info'
  get 'index/type'
  post 'index/type'
  get 'index/submit'
  post 'index/submit'
  get 'index/start'
  post 'index/start'
  get 'index/result'
  post 'index/result'

  root 'index#home'

  # Links for create user
  get 'users/new'
  post 'users/new'
  get 'users/create'
  post 'users/create'

  resources :questions do
  	resources :answers
  end

  resources :tests do
  	resources :relations
  	get 'relations/create_multiple'
  	post 'relations/create_multiple'
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
