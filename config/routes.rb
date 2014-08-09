Rails.application.routes.draw do
  get 'site/index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }

  resources :posts

  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  match '/profile' => 'users#profile', via: [:get, :patch], :as => :profile

  match '/404' => 'errors#not_found'            , :via => [:get, :post]
  match '/422' => 'errors#unprocessable_entity' , :via => [:get, :post]
  match '/500' => 'errors#application_error'    , :via => [:get, :post]
  root :to => 'site#index'
end
