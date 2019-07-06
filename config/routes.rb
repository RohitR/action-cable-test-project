Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  resources :games do
    collection do 
      post :host
      post :join 
      get :host_or_join
      get :play
    end
  end
  resources :moves
  root :to => "games#host_or_join"  
end
