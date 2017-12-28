Rails.application.routes.draw do
  get 'home/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'chats#index'

  mount ActionCable.server => '/cable'

  resources :users, only:[:new, :create, :index] do
   resources :chats do
   end
  end
  resources :users, controller: 'users', only: Clearance.configuration.user_actions


  resources :chats, only: [] do
     resources :messages, only:[:index]
  end

  resources :messages

end
