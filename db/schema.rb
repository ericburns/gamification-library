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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121210010350) do

  create_table "admins", :force => true do |t|
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "username"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "string"
    t.string   "salt"
  end

  create_table "badges", :force => true do |t|
    t.string   "game_id",                                :null => false
    t.string   "badge_name",                             :null => false
    t.string   "badge_image", :default => "default.png", :null => false
    t.integer  "awarded_at",  :default => 1,             :null => false
    t.text     "badge_info"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  create_table "emails", :force => true do |t|
    t.string   "user_id",    :null => false
    t.string   "email",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "friend_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "games", :force => true do |t|
    t.string   "gamename",                      :null => false
    t.text     "description",                   :null => false
    t.string   "unit",        :default => "XP", :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "inventories", :force => true do |t|
    t.string   "user_id",    :null => false
    t.string   "badge_id",   :null => false
    t.integer  "amount"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "levels", :force => true do |t|
    t.string   "game_id",                          :null => false
    t.integer  "xp_to_next_level", :default => -1, :null => false
    t.integer  "levelno",          :default => 1,  :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username",                          :null => false
    t.string   "game_id",                           :null => false
    t.integer  "xp",                 :default => 0, :null => false
    t.string   "encrypted_password"
    t.string   "salt"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

end
