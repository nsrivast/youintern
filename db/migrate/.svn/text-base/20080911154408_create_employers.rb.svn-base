class CreateEmployers < ActiveRecord::Migration
  def self.up
    create_table :employers do |t|
      t.column :coid,                 :integer
      t.column :username,             :string,            :null => false
      t.column :hashed_password,      :string
      t.column :salt,                 :string
      
      t.column :company_name,         :string,            :null => false
      t.column :company_location,     :string
      t.column :company_locationzip,  :integer,           :limit => 5
      t.column :company_website,      :string
      t.column :company_email,        :string
      t.column :company_about,        :text
      t.column :company_rating,       :float
      t.column :company_iid,          :integer            # industry id
      
      t.column :rep_first_name,       :string
      t.column :rep_last_name,        :string
      t.column :rep_email,            :string
      t.column :rep_title,            :string
      t.column :rep_phone,            :integer
      t.column :rep_about,            :text
      
      t.column :logo,                 :binary,            :limit => 1.megabyte
      t.column :logo_small,           :binary,            :limit => 1.megabyte

      t.timestamps
    end
  end

  def self.down
    drop_table :employers
  end
end
