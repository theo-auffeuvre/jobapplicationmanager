Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "pages#home"

  resources :jobs do
    resources :tasks
  end

  resources :tasks, only: [:index, :show, :edit, :update, :destroy]

  resources :contacts

  resources :documents

  resources :contact_jobs, only: [:create, :destroy]

  patch "/jobs/:id/update_status", to: "jobs#update_status", as: "update_status"

  get "/companies/search_company", to: "companies#search_company", as: "search_company"

end
