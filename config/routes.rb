Rails.application.routes.draw do

  root to: "session#new"
  # get 'items/new'
  # get 'items/create'
  # get 'items/show'
  # get 'items/edit'
  # get 'items/update'
  # get 'items/destroy'
  resources :users, except: [ :index ]

  # get 'session/new'
  # get 'session/create'
  # get 'session/destroy'
  # get 'users/new'
  # get 'users/create'
  # get 'users/show'
  # get 'users/edit'
  # get 'users/update'
  # get 'users/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Session routes for login/logut
get    "/login" => "session#new"     # login form
post   "/login" => "session#create"  # form submits here to perform login and set session
delete "/login" => "session#destroy" # logout (delete session)

resources :items

#post "items/search" => "items#search", as: 'search_items'
end
