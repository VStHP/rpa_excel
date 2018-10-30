# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_10_30_014736) do

  create_table "formulas", force: :cascade do |t|
    t.string "data"
    t.integer "templates_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["templates_id"], name: "index_formulas_on_templates_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.float "maths"
    t.float "physics"
    t.float "chemistry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "templates", force: :cascade do |t|
    t.string "file"
    t.string "attachable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trackings", force: :cascade do |t|
    t.string "user_name"
    t.datetime "check_in"
    t.datetime "check_out"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
