Rails.application.routes.draw do
  root 'templates#index'
  resources :templates do
    collection do
      post :load_file
    end
  end
  resources :trackings do
    collection do
      get :export_xlsx, format: :xlsx
    end
  end
  post :import_template, to: 'excel#import_template'
  resources :students do
    collection do
      get :export_xlsx, format: :xlsx
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
