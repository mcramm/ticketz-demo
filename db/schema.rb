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

ActiveRecord::Schema[7.0].define(version: 2022_02_17_144013) do
  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seats", force: :cascade do |t|
    t.string "number"
    t.integer "theatre_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["theatre_id"], name: "index_seats_on_theatre_id"
  end

  create_table "showtimes", force: :cascade do |t|
    t.datetime "starts_at"
    t.integer "theatre_id", null: false
    t.integer "movie_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_showtimes_on_movie_id"
    t.index ["theatre_id"], name: "index_showtimes_on_theatre_id"
  end

  create_table "theatres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "seat_id", null: false
    t.integer "showtime_id", null: false
    t.integer "customer_id"
    t.integer "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_tickets_on_customer_id"
    t.index ["seat_id"], name: "index_tickets_on_seat_id"
    t.index ["showtime_id"], name: "index_tickets_on_showtime_id"
  end

  add_foreign_key "seats", "theatres"
  add_foreign_key "showtimes", "movies"
  add_foreign_key "showtimes", "theatres"
  add_foreign_key "tickets", "customers"
  add_foreign_key "tickets", "seats"
  add_foreign_key "tickets", "showtimes"
end
