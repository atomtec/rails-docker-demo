Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'books' => 'books#index'
      post 'books' => 'books#create'
      delete 'books/:id' => 'books#destroy'
      post 'authenticate' => 'authentication#create'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
