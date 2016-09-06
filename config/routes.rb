Rails.application.routes.draw do
  

  namespace :admin do
  
  end

  namespace :admin do
  get 'procedures/new'
  end

  namespace :admin do
  get 'procedures/edit'
  end

  namespace :admin do
  get 'procedures/index'
  end

  namespace :admin do
  get 'procedures/show'
  end

  resources :reviews

  devise_for :providers
  
  devise_scope :provider do
    get "/sign_up" => "devise/registrations#new"
  end
  
  resources :procedures 
  resources :providers

  namespace :admin do 
    
    root 'static_pages#welcome'

    resources :providers do 
      resources :procedures
    end
  end
     

  get "/procedure_list" => "static_pages#procedure_list"

  get "/faq" => "static_pages#faq"
  get "/search_by_name" => "providers#search_by_name"
  get "/search_by_address" => "providers#search_by_address"

  root 'static_pages#welcome'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
