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

ActiveRecord::Schema.define(version: 2021_11_19_194423) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cages", force: :cascade do |t|
    t.integer "capacity", default: 10
    t.string "status"
    t.string "species_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "carnivores", force: :cascade do |t|
    t.string "species"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "cage_id"
    t.string "name"
    t.index ["cage_id"], name: "index_carnivores_on_cage_id"
  end

  create_table "dinosaurs", id: false, force: :cascade do |t|
    t.bigint "herbivore_id"
    t.bigint "carnivore_id"
    t.index ["carnivore_id", "herbivore_id"], name: "index_dinosaurs_on_carnivore_id_and_herbivore_id"
    t.index ["herbivore_id", "carnivore_id"], name: "index_dinosaurs_on_herbivore_id_and_carnivore_id"
  end

  create_table "herbivores", force: :cascade do |t|
    t.string "species"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "cage_id"
    t.string "name"
    t.index ["cage_id"], name: "index_herbivores_on_cage_id"
  end

end
