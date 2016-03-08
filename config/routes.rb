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
    get "/login" => "users/sessions#new"
  end

  get 'tags/:tag', to: 'posts#index', as: :tag

  resources :posts do
    collection do
      get 'list', action: :index_admin
    end
  end

  get 'dashboard' => 'admin#dashboard'
  get 'king_of_the_hill' => 'pages#king_of_the_hill'
  get 'contact' => 'pages#contact'
  get 'about' => 'pages#about'

  root 'home#index'
end
