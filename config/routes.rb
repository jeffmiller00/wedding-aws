require 'digest/md5'

Wedding::Application.routes.draw do
  resources :posts
  resources :guests
  resources :guest_categories

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static_pages#home'

  get '/our_story',       to: 'static_pages#our_story'
  get '/proposal',        to: 'static_pages#proposal'
  get '/wedding_party',   to: 'static_pages#wedding_party'
  get '/events',          to: 'static_pages#events'
  get '/accommodations',  to: 'static_pages#accommodations'

  get '/guestbook',       to: 'posts#index'
  #get '/posts/admin/toggle/:month/:day', to: "posts#login"

  get '/registries',      to: 'static_pages#registries'

  get  '/rsvp', to: 'rsvps#new', as: 'go_rsvp'
  post '/rsvps(.:format)', to: 'rsvps#create', as: 'rsvps'
  get  '/rsvps/new(.:format)', to: 'rsvps#new'


=begin
>>>>>>> 7774fab... Minor changes prior to better work flow.
  get 'rsvp' => "rsvp#index"
  post 'rsvp' => "rsvp#find"
  get 'rsvp/:ext_id' => 'rsvp#view'
  patch 'rsvp/confirm' => 'rsvp#confirm'

=begin
  get 'rsvp/:dig' do
    get 'rsvp/Digest::MD5.hexdigest( :dig )' => 'rsvp#view'
  end
=end
  #match 'disclaimer' => 'rsvp#disclaimer'
  #match 'details' => 'rsvp#details'
  #match 'confirm' => 'rsvp#confirm'
  #match 'finished' => 'rsvp#finished'



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
