Rails.application.routes.draw do
  get 'home/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'chats#index'

  mount ActionCable.server => '/cable'

  resources :users, only:[:new, :create] do
   resources :chats
  end

  resources :messages

end
