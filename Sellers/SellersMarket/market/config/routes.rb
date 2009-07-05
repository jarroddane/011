ActionController::Routing::Routes.draw do |map|
  map.resources :users

  
  map.resources :company_statuses

  map.resources :slips

  map.resources :employees, :slips, :data_entries

  map.resources :job_types

  map.resources :currencies

  map.resources :people

  map.resources :jobs

  map.resources :companies

  map.resources :responses

  map.resources :questions

  map.resources :surveys

  map.resources :shippings

  map.resources :customers

  map.resources :line_items

  map.resources :invoices

  map.resources :products
  
  
  # Lookup Resources

  	map.resources :job_types
  	map.resources :method_of_billing_controller, :currencies, :job_statuses
  	
  # User Management Section

    map.resource :session
    map.resources :employees
  
  
  # Widgets


  # Reports



  # works
  	
  	
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
  
  map.tasks 'tasks/:action/:id', :controller => 'tasks', :action => 'list'
  map.activites 'activities/:action/:id', :controller => 'activities', :action => 'list'
end
