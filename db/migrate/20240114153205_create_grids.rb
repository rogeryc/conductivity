class CreateGrids < ActiveRecord::Migration[7.1]
  def change
    create_table :grids do |t|
      t.string :outcome
      t.string :rows
      t.integer :dimension

      t.timestamps
    end
  end
end
