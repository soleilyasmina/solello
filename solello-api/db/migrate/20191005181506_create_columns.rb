class CreateColumns < ActiveRecord::Migration[6.0]
  def change
    create_table :columns do |t|
      t.string :title
      t.integer :order
      t.references :board, null: false, foreign_key: true

      t.timestamps
    end
  end
end
