class Column < ApplicationRecord
  belongs_to :board

  def self.swap column, new_order, parent
    if new_order.to_i > parent.columns.length
      new_order = parent.columns.length - 1
    end
    # going left
    order = column[:order]
    if new_order < order
      columns = Column.where(order: new_order...order, board_id: parent.id)
      columns.each do |col|
        if col.id == column.id
          col.update({ order: new_order })
        else
          col.update({ order: col.order + 1 })
        end
      end
      column.update({ order: new_order })
      # going right
    elsif order < new_order
      columns = Column.where(order: order+1..new_order, board_id: parent.id)
      columns.each do |col|
        if col.id == column.id
          col.update({ order: new_order })
        else
          col.update({ order: col.order - 1 })
        end
      end
      column.update({ order: new_order })
      # they're the same
    else
      false
    end
    true
  end

  def self.cleanup column
    board = Board.find(column.board_id)
    columns = Column.where(order: column.order..board.columns.length, board_id: board.id)
    columns.each do |col|
      col.update({ order: col.order - 1 })
    end
  end

end
