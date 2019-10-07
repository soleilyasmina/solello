class Task < ApplicationRecord
  belongs_to :column

  def self.swap task, new_order, parent_column
    new_order = new_order.to_i
    if new_order > parent_column.tasks.length
      new_order = parent_column.tasks.length - 1
    end
    # going left
    order = task[:order]
    if new_order < order
      tasks = Task.where(order: new_order...order, column_id: parent_column.id)
      tasks.each do |t|
        if t.id == task.id
          t.update({ order: new_order })
        else
          t.update({ order: t.order + 1 })
        end
      end
      task.update({ order: new_order })
      # going right
    elsif order < new_order
      tasks = Task.where(order: order+1..new_order, column_id: parent_column.id)
      tasks.each do |t|
        if t.id == column.id
          t.update({ order: new_order })
        else
          t.update({ order: t.order - 1 })
        end
      end
      task.update({ order: new_order })
      # they're the same
    else
      false
    end
    true
  end

  def self.cleanup task
    column = Column.find(task.column_id)
    tasks = Task.where(order: task.order..column.tasks.length, column_id: column.id)
    tasks.each do |t|
      t.update({ order: t.order - 1 })
    end
  end

end
