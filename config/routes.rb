Rails.application.routes.draw do
  resources :cats do
    member do
      get :approve
    end
  end
  resources :dogs do
    member do
      get :approve
    end
  end
  root 'dogs#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
