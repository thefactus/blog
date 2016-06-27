Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    unlocks: 'users/unlocks'
  }

  devise_scope :user do
  end

  get 'tags/:tag', to: 'posts#tagged_with', as: :tag

  resources :posts do
    collection do
      get 'list', action: :index_admin
      get 'search', action: :search
    end
    resources :comments, only: [:create, :destroy]
  end

  get 'admin' => 'admin#index'
  get 'contact' => 'pages#contact'
  get 'about' => 'pages#about'

  root 'home#index'
end
