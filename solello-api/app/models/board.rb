class Board < ApplicationRecord
  has_many :columns

  def self.all_assoc
    Board.all.to_json(include: {columns: { include: :tasks }})
  end

  def with_assoc
    self.to_json(include: {columns: { include: :tasks }})
  end
end
