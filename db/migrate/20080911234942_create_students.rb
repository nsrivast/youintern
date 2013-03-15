class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.column :uid, :integer
      t.string :username, :hashed_password, :salt
      t.string :first_name, :last_name, :email, :location, :desired_location
      t.integer :location_zip, :desired_location_zip
      t.text :about_me, :interested_in, :skills
      
      t.column :resume,         :binary, :limit => 1.megabyte
      t.column :coverletter,    :binary, :limit => 1.megabyte

      t.timestamps
    end
  end

  def self.down
    drop_table :students
  end
end
