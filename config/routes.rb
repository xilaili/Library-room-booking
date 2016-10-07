Rails.application.routes.draw do

  root 'static_pages#home'
  
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    'admins'      => 'users#adminlist'
  get    'createuseradmin'      => 'users#new'
  
  resources :users
  get  '/users/:id(.:format)/upgrade' => 'users#upgrade'
  get  '/users/:id(.:format)/downgrade' => 'users#downgrade'

  resources :rooms
  get   'update'  => 'rooms#update'
 
  resources :histories
  get   'search'  => 'histories#search'
  
end