class CreateSteps < ActiveRecord::Migration[7.1]
  def change
    create_table :steps do |t|
      t.references :solution, null: false, foreign_key: true
      t.integer :sequence
      t.integer :row
      t.integer :index

      t.timestamps
    end
  end
end
