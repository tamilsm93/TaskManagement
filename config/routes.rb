Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {

    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {

    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }

resources :tasks
resources :categories, only: [:create, :index]


get 'task/category/:id', to: 'tasks#category'

resources :workspaces, only: [:create, :index]

resources :memberships, only: [:create, :index]


post 'workspaces/:id/', to: 'workspaces#add_member'


post 'search/', to: 'tasks#search'

devise_scope :user do
  post 'otplogin', to: 'users/sessions#otplogin'
end


# post 'categories', to: 'task_categories#create'
end
