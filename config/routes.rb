Eras::Engine.routes.draw do
  root to: 'errors#index'
  resources :errors, only: [:index, :show] do
    collection do
      post 'destroy_all', to: 'errors#destroy'
    end
  end
end
