Rails.application.routes.draw do
  get 'shared/map_location'
  get 'manager/index'
  get 'driver/index'
  get 'pages/home'
  root 'pages#home'
  devise_for :managers
  devise_for :drivers
  resources :tasks
  get '/tasks/:id/update_to_done', to:  'tasks#update_to_done', as: 'update_to_done'
  get '/list_task_nearby', to: 'tasks#list_task_nearby'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
