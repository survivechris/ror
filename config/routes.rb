Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#home'
  get 'about', to: 'welcome#about'

  # add all the routes for articles
  resources :articles

  # signup user page
  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  # user login
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
