require_dependency "search"

class Review < ActiveRecord::Base 
  
  belongs_to :employer
  belongs_to :student
  
  # ------- custom conditions -------
  searches_on :all

  def self.filter(ss, params)
    conditions = params["advice"] ? '(advice <> "" )' : nil
    
    found_reviews = Review.search(ss, {:conditions => conditions})
    
    # --- filter results: RECENT, RATING THRESHOLD
    filtered_reviews = []

    found_reviews.each do |e|
      recent_ok = params["recent"] ? ((2008 - e.year.to_i) < params["interval"].to_i) : true 
      threshold_ok = params["threshold"] ? (e.rating_overall.to_i >= params["rating_thresh"].to_i) : true 
      
      filtered_reviews << e if recent_ok and threshold_ok
    end

    filtered_reviews
  end
  
  def self.latest(n)
    Review.find(:all, :limit => n, :order => "updated_at DESC")
  end
end
