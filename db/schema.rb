# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090315052508) do

  create_table "admins", :force => true do |t|
    t.string   "username"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blogs", :force => true do |t|
    t.integer "nid",                                  :default => 0,  :null => false
    t.integer "created_at_old",                       :default => 0,  :null => false
    t.integer "updated_at_old",                       :default => 0,  :null => false
    t.string  "title",          :limit => 128,        :default => "", :null => false
    t.text    "body",           :limit => 2147483647,                 :null => false
    t.text    "teaser",         :limit => 2147483647,                 :null => false
    t.integer "timestamp",                            :default => 0,  :null => false
  end

  create_table "employers", :force => true do |t|
    t.integer  "coid"
    t.string   "username",                                :default => "", :null => false
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "company_name",                            :default => "", :null => false
    t.string   "company_location"
    t.integer  "company_locationzip", :limit => 8
    t.string   "company_website"
    t.string   "company_email"
    t.text     "company_about"
    t.float    "company_rating"
    t.integer  "company_iid"
    t.string   "rep_first_name"
    t.string   "rep_last_name"
    t.string   "rep_email"
    t.string   "rep_title"
    t.string   "rep_phone",           :limit => 128
    t.text     "rep_about"
    t.integer  "logo"
    t.binary   "logo_small",          :limit => 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "featured"
  end

  create_table "internships", :force => true do |t|
    t.integer  "employer_id"
    t.integer  "fiid"
    t.integer  "funid"
    t.string   "department"
    t.string   "title"
    t.string   "location"
    t.integer  "location_zip"
    t.text     "description"
    t.text     "requirements"
    t.text     "commitment"
    t.text     "compensation"
    t.text     "how"
    t.integer  "deadline_year"
    t.integer  "deadline_month"
    t.string   "contact"
    t.string   "contact_email"
    t.string   "contact_phone",  :limit => 128
    t.integer  "start_month"
    t.integer  "start_year"
    t.integer  "end_month"
    t.integer  "end_year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "featured"
    t.integer  "regional",                      :default => 0,   :null => false
    t.float    "latitude",                      :default => 0.0, :null => false
    t.float    "longitude",                     :default => 0.0, :null => false
    t.string   "extra1"
    t.string   "extra2"
    t.string   "extra3"
    t.string   "cb_string",      :limit => 100
  end

  add_index "internships", ["employer_id"], :name => "fk_internships_employers"

  create_table "internships_students", :id => false, :force => true do |t|
    t.integer "internship_id", :default => 0, :null => false
    t.integer "student_id",    :default => 0, :null => false
  end

  create_table "old_employers", :id => false, :force => true do |t|
    t.string "rep_email",    :limit => 128, :default => "", :null => false
    t.string "username",     :limit => 128, :default => "", :null => false
    t.string "company_name", :limit => 128, :default => "", :null => false
  end

  create_table "reviews", :force => true do |t|
    t.integer  "student_id"
    t.integer  "employer_id"
    t.string   "review_name"
    t.string   "department"
    t.string   "job_title"
    t.string   "city"
    t.string   "state"
    t.string   "semester"
    t.integer  "year"
    t.integer  "rating_treatment"
    t.integer  "rating_participation"
    t.integer  "rating_networking"
    t.integer  "rating_opportunity"
    t.integer  "rating_responsibility"
    t.integer  "rating_development"
    t.integer  "rating_overall"
    t.text     "compensation"
    t.text     "responsibilities"
    t.text     "environment"
    t.text     "interview"
    t.text     "advice"
    t.text     "offer"
    t.text     "review"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["employer_id"], :name => "fk_reviews_employers"
  add_index "reviews", ["student_id"], :name => "fk_reviews_students"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :default => "", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "students", :force => true do |t|
    t.integer  "uid"
    t.string   "username"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "location"
    t.string   "desired_location"
    t.integer  "location_zip"
    t.integer  "desired_location_zip"
    t.text     "about_me"
    t.text     "interested_in"
    t.text     "skills"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "school",               :limit => 128
    t.integer  "grad_year",                           :default => 0
    t.boolean  "huntable",                            :default => false
    t.integer  "resume",                              :default => 0,     :null => false
  end

end
