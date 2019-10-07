Rails.application.routes.draw do
  resources :boards
  resources :columns
  put '/columns/:id/:new_order', to: 'columns#swap_columns'
end
