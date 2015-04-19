Rails.application.routes.draw do

  # main controller 
  get 'main/index'
  root 'main#index'

  # comments end points
  get '/comments/list' => 'comments#list'
  resources :comments, only: [:create, :destroy]
  get '/comments/new/(:parent_id)' => 'comments#new', as: :new_comment

  # image end points
  resources :images, only: [:create, :destroy]

  # post end points
  get 'posts/list' => 'posts#list'
  resources :posts, only: [:list, :show, :create, :update, :destroy]

  # user end posints
  resources :users, only: [:create, :show]

  # report end points
  get 'report/activities_by_city'
  get 'reports' => 'report#activities_by_city'

end
