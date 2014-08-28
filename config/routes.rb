Rails.application.routes.draw do
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  # 아래와 같이 기본적인 CRUD에 대해서 명시적으로 Routing을 설정하는 방법을 권하지 않습니다.
  # 이해를 돕기 위하여 추가하였습니다.

  # match '/posts', to: 'posts#index', via: :GET
  # match '/posts', to: 'posts#create', via: :POST
  # match '/posts/new', to: 'posts#new', via: :GET, as: 'new_post'
  # match '/posts/:id/edit', to: 'posts#edit', via: :GET, as: 'edit_post'
  # match '/posts/:id', to: 'posts#show', via: :GET, as: 'post'
  # match '/posts/:id', to: 'posts#update', via: :PATCH
  # match '/posts/:id', to: 'posts#update', via: :PUT
  # match '/posts/:id', to: 'posts#destroy', via: :DELETE
  #
  # match 'posts/:post_id/comments', to: 'comments#create', via: :POST, as: 'post_comments'
  # match 'posts/:post_id/comments/:id', to: 'comments#destroy', via: :DELETE, as: 'post_comment'

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
