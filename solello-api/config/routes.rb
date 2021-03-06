Rails.application.routes.draw do
  resources :tasks, path: 'columns/:column_id/tasks'
  put '/tasks/:id/:new_order', to: 'tasks#swap_tasks'
  put '/columns/:column_id/tasks/:id/:new_order', to: 'tasks#swap_columns'
  resources :boards do
    resources :columns
    put '/columns/:id/:new_order', to: 'columns#swap_columns'
  end
end
