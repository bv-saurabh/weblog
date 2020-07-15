Rails.application.routes.draw do
	devise_config = ActiveAdmin::Devise.config
	devise_config[:controllers][:omniauth_callbacks] = 'admin_users/omniauth_callbacks'
  devise_for :admin_users, devise_config
  ActiveAdmin.routes(self)
  devise_for :users
  get 'welcome/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
	
	resources :articles
	
	root 'welcome#index'
end
