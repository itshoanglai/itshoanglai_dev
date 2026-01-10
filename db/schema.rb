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

ActiveRecord::Schema[7.2].define(version: 2026_01_10_090729) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "medical_staffs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "fullname", null: false
    t.string "hashid", null: false
    t.date "dob"
    t.string "phone"
    t.integer "gender"
    t.string "work_email"
    t.string "private_email"
    t.string "nickname"
    t.string "role", null: false
    t.jsonb "app_settings", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hashid"], name: "index_medical_staffs_on_hashid", unique: true
    t.index ["user_id"], name: "index_medical_staffs_on_user_id", unique: true
    t.index ["work_email"], name: "index_medical_staffs_on_work_email"
  end

  create_table "patients", force: :cascade do |t|
    t.bigint "user_id"
    t.string "fullname", null: false
    t.string "hashid", null: false
    t.date "dob"
    t.string "phone"
    t.integer "gender"
    t.string "work_email"
    t.string "private_email"
    t.string "nickname"
    t.bigint "points", default: 0, null: false
    t.jsonb "app_settings", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hashid"], name: "index_patients_on_hashid", unique: true
    t.index ["user_id"], name: "index_patients_on_user_id", unique: true
    t.index ["work_email"], name: "index_patients_on_work_email"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "hashid", null: false
    t.integer "failed_attempts", default: 0, null: false
    t.boolean "deactivated", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["hashid"], name: "index_users_on_hashid", unique: true
  end

  add_foreign_key "medical_staffs", "users"
  add_foreign_key "patients", "users"
end
