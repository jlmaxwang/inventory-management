Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :powders do
    collection do
      get :import, :export
      post :import_powder, :export_powder
    end
  end
end
