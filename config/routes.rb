Rails.application.routes.draw do

  root 'sesion#login'

  resources :usuarios
  resources :clientes
  resources :sesion, :only => [:crear, :destruir, :login]

  #get 'login/index'
  #match ':controller(/:action(/:id))', via: [:get, :post]
  get '/login' => 'sesion#login'
  post '/login' => 'sesion#crear'
  get '/logout' => 'sesion#destruir'

  get '/home' => 'menu#index'

  get 'usuarios/new' => 'usuario#new'
  get 'usuarios' => 'usuario#index'
  get 'Admin' => 'usuario#index'

  get 'gestion' => 'menu#index'


  get 'cotizaciones' => 'menu#index'
  get 'cotizaciones/administrar' => 'cotizaciones#administrar'
  get 'cotizaciones/selCliente'
  get 'cotizaciones/buscarCliente' => 'cotizaciones#buscarCliente'

  get 'clientes' => 'clientes#index'
  get 'clientes/new' => 'clientes#new'
  post 'clientes/create' => 'clientes#create'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'sesion#login'


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
