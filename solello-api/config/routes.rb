Rails.application.routes.draw do
  resources :tasks, path: 'columns/:column_id/tasks'
  resources :boards do
    resources :columns
    put '/columns/:id/:new_order', to: 'columns#swap_columns'
  end
  
end
