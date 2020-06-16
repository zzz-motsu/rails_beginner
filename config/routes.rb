Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  get "/users/:id", to: "users#show"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'questions#index'
  # get "/questions", to: "questions#index"
  # get "/questions/new", to: "questions#new"
  # post "/questions", to: "questions#create"
  # get "/questions/:id", to: "questions#show"
  # get "/questions/:id/edit", to: "questions#edit"
  # patch "/questions/:id", to: "questions#update"
  # delete "/questions/:id", to: "questions#destroy"
  resources :questions do
    resources :answers, only: [:create]
  end
end
