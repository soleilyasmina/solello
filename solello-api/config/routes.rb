Rails.application.routes.draw do
  resources :columns
  put '/columns/:id/:new_order', to: 'columns#swap'
  resources :boards
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
