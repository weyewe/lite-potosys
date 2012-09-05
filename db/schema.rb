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

ActiveRecord::Schema.define(:version => 20120905062955) do

  create_table "assignments", :force => true do |t|
    t.integer  "role_id"
    t.integer  "job_attachment_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "clients", :force => true do |t|
    t.integer  "office_id"
    t.integer  "creator_id"
    t.string   "name"
    t.text     "address"
    t.string   "mobile"
    t.string   "home_phone"
    t.string   "bb_pin"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "deliverable_component_subcriptions", :force => true do |t|
    t.integer  "deliverable_component_id"
    t.integer  "deliverable_item_id"
    t.integer  "project_id"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "deliverable_components", :force => true do |t|
    t.string   "name"
    t.integer  "deliverable_id"
    t.integer  "office_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "deliverable_items", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "deliverable_subcriptions", :force => true do |t|
    t.integer  "package_id"
    t.integer  "deliverable_id"
    t.integer  "package_specific_sub_item_quantity"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "deliverables", :force => true do |t|
    t.integer  "office_id"
    t.string   "name"
    t.text     "description"
    t.string   "sub_item_name"
    t.boolean  "has_sub_item",                                              :default => false
    t.integer  "sub_item_quantity"
    t.decimal  "independent_price",          :precision => 11, :scale => 2, :default => 0.0
    t.decimal  "independent_sub_item_price", :precision => 11, :scale => 2, :default => 0.0
    t.datetime "created_at",                                                                   :null => false
    t.datetime "updated_at",                                                                   :null => false
  end

  create_table "drafts", :force => true do |t|
    t.text     "overall_feedback"
    t.integer  "number"
    t.integer  "creator_id"
    t.integer  "project_id"
    t.integer  "deliverable_item_id"
    t.integer  "deliverable_component_subcription_id"
    t.date     "start_draft_date"
    t.date     "proposed_deadline_date"
    t.integer  "deadline_proposer_id"
    t.date     "granted_deadline_date"
    t.integer  "deadline_grantor_id"
    t.date     "actual_deadline_date"
    t.integer  "actual_deadline_approver_id"
    t.boolean  "is_finished",                          :default => false
    t.date     "finish_date"
    t.integer  "finisher_id"
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
  end

  create_table "job_attachments", :force => true do |t|
    t.integer  "office_id"
    t.integer  "user_id"
    t.boolean  "is_active",  :default => false
    t.boolean  "is_deleted", :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "job_requests", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "offices", :force => true do |t|
    t.string   "name"
    t.integer  "main_user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "packages", :force => true do |t|
    t.integer  "office_id"
    t.string   "name"
    t.text     "description"
    t.decimal  "base_price",               :precision => 12, :scale => 2, :default => 0.0
    t.boolean  "is_crew_specific_pricing",                                :default => false
    t.integer  "number_of_crew",                                          :default => 1
    t.datetime "created_at",                                                                 :null => false
    t.datetime "updated_at",                                                                 :null => false
  end

  create_table "project_assignments", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "project_memberships", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "project_roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects", :force => true do |t|
    t.integer  "office_id"
    t.integer  "creator_id"
    t.string   "title"
    t.text     "concept"
    t.boolean  "is_concept_finished"
    t.date     "concept_finish_date"
    t.integer  "concept_finisher_id"
    t.boolean  "is_property_hunting_finished"
    t.date     "property_hunting_finish_date"
    t.integer  "property_hunting_finisher_id"
    t.date     "shoot_date"
    t.date     "shoot_starting_date"
    t.date     "shoot_ending_date"
    t.string   "shoot_location"
    t.integer  "total_raw_file"
    t.integer  "total_project_file"
    t.string   "raw_file_storage_location"
    t.string   "project_file_storage_location"
    t.boolean  "is_production_started"
    t.date     "production_starting_date"
    t.boolean  "is_production_finished"
    t.date     "production_finishing_date"
    t.integer  "production_starter_id"
    t.integer  "production_finisher_id"
    t.boolean  "is_post_production_started"
    t.date     "post_production_starting_date"
    t.boolean  "is_post_production_finished"
    t.date     "post_production_finishing_date"
    t.integer  "post_production_starter_id"
    t.integer  "post_production_finisher_id"
    t.integer  "package_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "suppliers", :force => true do |t|
    t.integer  "office_id"
    t.string   "name"
    t.text     "address"
    t.string   "office_phone"
    t.string   "email"
    t.string   "mobile"
    t.string   "contact_person_name"
    t.string   "contact_person_bb_pin"
    t.string   "contact_person_email"
    t.string   "contact_person_mobile"
    t.integer  "creator_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name",                   :default => "", :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
