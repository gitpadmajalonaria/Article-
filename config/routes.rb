Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "notes#index"

  resources :notes do
     resources :comments 
  end

  resources :notes do
    resources :likes
  end

end
