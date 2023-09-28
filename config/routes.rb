Rails.application.routes.draw do 
  resources :users, param: :_username
  
  namespace :admin do
    resources :admins, param: :_username
  end

  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
end 
