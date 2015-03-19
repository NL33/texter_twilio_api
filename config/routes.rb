Rails.application.routes.draw do

 root 'messages#index'
 devise_for :users


 resources :messages, :only => [:index, :new, :create, :show]
 
 resources :contacts do 
   resources :messages
 end

  resources :users, :only => [:show]  
 	
 end




