# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_240_114_165_345) do
  create_table 'grids', force: :cascade do |t|
    t.string 'outcome'
    t.string 'rows'
    t.integer 'dimension'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'solutions', force: :cascade do |t|
    t.integer 'grid_id', null: false
    t.integer 'number'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['grid_id'], name: 'index_solutions_on_grid_id'
  end

  create_table 'steps', force: :cascade do |t|
    t.integer 'solution_id', null: false
    t.integer 'sequence'
    t.integer 'row'
    t.integer 'index'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['solution_id'], name: 'index_steps_on_solution_id'
  end

  add_foreign_key 'solutions', 'grids'
  add_foreign_key 'steps', 'solutions'
end
