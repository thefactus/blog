Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
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

  resources :posts, only: [:show] do
    resources :comments, only: [:create, :destroy]
  end

  # get 'admin' => 'admin#index'
  get 'contact' => 'pages#contact'
  get 'about' => 'pages#about'

  root 'home#index'
end
