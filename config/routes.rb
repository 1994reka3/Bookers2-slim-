Rails.application.routes.draw do
  root 'home#top'
  get '/home/about' => 'home#about'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  scope module: :users do
    resources :users, only: [:index, :show, :edit, :update]
  end
  resources :books, except: [:new]
end
