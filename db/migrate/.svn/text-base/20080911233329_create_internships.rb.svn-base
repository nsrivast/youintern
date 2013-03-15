class CreateInternships < ActiveRecord::Migration
  def self.up
    create_table :internships do |t|
      t.column :employer_id,    :integer
      t.column :fiid,           :integer
      t.column :funid,          :integer
      
      t.column :department,     :string
      t.column :title,          :string
      t.column :location,       :string
      t.column :location_zip,   :integer
      
      t.column :description,    :text
      t.column :requirements,   :text
      t.column :commitment,     :text
      t.column :compensation,   :text
      t.column :how,            :text
      t.column :deadline,       :datetime
      t.column :contact,        :string
      t.column :contact_email,  :string
      t.column :contact_phone,  :integer
      
      t.column :start_month,    :integer
      t.column :start_year,     :integer
      t.column :end_month,      :integer
      t.column :end_year,       :integer
      
      t.column :extra1,         :string
      t.column :extra2,         :string
      t.column :extra3,         :string

      t.timestamps
    end
    
        execute "alter table internships add constraint fk_internships_employers 
                foreign key (employer_id) references employers(id)"
  end

  def self.down
    drop_table :internships
  end
end
