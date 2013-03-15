class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.column :student_id,     :integer
      t.column :employer_id,    :integer
      
      t.column :review_name,    :string
      t.column :department,     :string
      t.column :job_title,      :string
      t.column :city,           :string
      t.column :state,          :string
      t.column :semester,       :string
      t.column :year,           :integer
      
      t.column :rating_treatment,         :integer
      t.column :rating_participation,     :integer
      t.column :rating_networking,        :integer
      t.column :rating_opportunity,       :integer
      t.column :rating_responsibility,    :integer
      t.column :rating_development,       :integer
      t.column :rating_overall,           :integer
      
      t.column :compensation,             :text
      t.column :responsibilities,         :text
      t.column :environment,              :text
      t.column :interview,         :text
      t.column :advice,         :text
      t.column :offer,         :text
      t.column :review,         :text

      t.timestamps
    end
    
    execute "alter table reviews add constraint fk_reviews_employers 
             foreign key (employer_id) references employers(id)"
    
    execute "alter table reviews add constraint fk_reviews_students 
             foreign key (student_id) references students(id)"

  end

  def self.down
    drop_table :reviews
  end
end
