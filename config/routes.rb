Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: 'devise/sessions#new'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :powders do
    collection do
      get :import, :export
      post :import_powder, :export_powder
    end
  end
  resources :export_lists, only: [:new, :create]
  resources :suppliers
  resources :customers
end
