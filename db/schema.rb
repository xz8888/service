# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140123185630) do

  create_table "comments", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "is_private"
    t.integer  "user_id"
    t.integer  "ticket_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "departments", force: true do |t|
    t.string   "department_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "style_name"
    t.string   "size"
    t.string   "color"
    t.string   "description"
    t.integer  "po_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ticket_id"
  end

  create_table "repair_codes", force: true do |t|
    t.string   "repair_codes"
    t.string   "repair_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repair_codes_tickets", id: false, force: true do |t|
    t.integer "ticket_id",      null: false
    t.integer "repair_code_id", null: false
  end

  add_index "repair_codes_tickets", ["repair_code_id"], name: "index_repair_codes_tickets_on_repair_code_id", using: :btree
  add_index "repair_codes_tickets", ["ticket_id"], name: "index_repair_codes_tickets_on_ticket_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: true do |t|
    t.integer "user_id", null: false
    t.integer "role_id", null: false
  end

  add_index "roles_users", ["role_id"], name: "index_roles_users_on_role_id", using: :btree
  add_index "roles_users", ["user_id"], name: "index_roles_users_on_user_id", using: :btree

  create_table "tickets", force: true do |t|
    t.string   "title",                   default: "", null: false
    t.text     "description"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "city"
    t.string   "province"
    t.string   "postalcode"
    t.boolean  "address_confirm"
    t.integer  "user_id"
    t.string   "receive_from"
    t.string   "last_contacted_customer"
    t.datetime "date_in"
    t.datetime "date_due"
    t.datetime "date_ready"
    t.datetime "date_out"
    t.string   "shipping_service"
    t.string   "shipping_date"
    t.string   "tracking_number"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country"
    t.string   "phone_number"
    t.integer  "reporter_id"
    t.integer  "department_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
