class CreateSolutions < ActiveRecord::Migration[7.1]
  def change
    create_table :solutions do |t|
      t.references :grid, null: false, foreign_key: true
      t.integer :step
      t.integer :row
      t.integer :index

      t.timestamps
    end
  end
end
