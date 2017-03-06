Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "questions#index"
  devise_for :users

  resources :questions do
    resources :answers, only: [:new, :create]
  end
end
