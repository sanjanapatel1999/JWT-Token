Rails.application.routes.draw do 
  
  
  
  namespace :customer do
    resources :users, param: :_username
    resources :carts 
    resources :wishlists
  end

  namespace :admin do
    resources :admins, param: :_username
  end

  namespace :supplier do
    resources :suppliers, param: :_username
    resources :products
  end


  root 'supplier/products#index'
  get '/search' , to: 'searchs#search'


  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end 
