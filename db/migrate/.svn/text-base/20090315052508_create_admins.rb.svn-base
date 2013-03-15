class CreateAdmins < ActiveRecord::Migration
  def self.up
    create_table :admins do |t|
      t.string :username, :hashed_password, :salt
      t.string :first_name, :last_name, :email
      
      t.timestamps
    end
  end

  def self.down
    drop_table :admins
  end
end
