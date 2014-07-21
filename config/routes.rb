Rails.application.routes.draw do
 devise_for :users, :controllers => { registrations: 'registrations' }

  get 'welcome/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'welcome#index'

  # Example of regular route:
    #get 'user/:id' => 'welcome#index'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #resources :articles
  resources :categories #do
  resources :articles do
    resources :tags
  end
  
  resources :users 
  resources :profilepics
  get "articles/:id/approve" => "articles#approve", :as => "approve_article"
  
  resources :users do
     resources :comments
  end
   resources :articles do
     resources :comments
  end
 
  
  #resources :articles do
   # put :approve
  #end
#end
  #scope "/admin" do
    #resources :users
  #end
 
  #get "articles/:id/category/show" => "categories#show", :as => "show_category"
  #get "/users/sign_out" => "devise/sessions#destroy" 
  
 
  #resources :tags
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
