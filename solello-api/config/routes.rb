Rails.application.routes.draw do
<<<<<<< HEAD
  resources :tasks, path: 'columns/:column_id/tasks'
  put '/tasks/:id/:new_order', to: 'tasks#swap_tasks'
  put '/columns/:column_id/tasks/:id/:new_order', to: 'tasks#swap_columns'
  resources :boards do
    resources :columns
    put '/columns/:id/:new_order', to: 'columns#swap_columns'
  end
  
=======
  resources :boards do
    resources :columns
  end
  put '/columns/:id/:new_order', to: 'columns#swap_columns'
>>>>>>> 8863ee67607bd955f557ea4a9a864b69928d993c
end
