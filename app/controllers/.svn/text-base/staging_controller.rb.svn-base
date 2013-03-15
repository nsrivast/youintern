require 'rss/2.0'
require 'open-uri'

class StagingController < ApplicationController
  
  def sub_layout
    "staging"
  end
  
  def some_internships
    @display_right = true
    
    {:paid => false, :course_credit => false,
      :start_month_a => 1, :start_month_b => 12, :end_month_a => 1, :end_month_b => 12,
      :start_year_a => 2009, :start_year_b => 2015, :end_year_a => 2009, :end_year_b => 2015,
      :ca => false, :ma => false, :ny => false}.map{|k,v| params[k] = v}

    @internships = Internship.find(:all, :limit => 8, :conditions => 'featured > -1', :order => 'created_at desc')
  end
  
  def filter_internships
    @keyword = params[:filter_keyword]
    @internships =  Internship.filter(@keyword, params)
   
    render :partial => 'filtered_internships', :layout => false
  end
  
  def some_employers
    @display_right = true
    
    @IID_MAP = {'2'=>' Administrative & Clerical', '3'=>' Advertising & Marketing', '31'=>' Aerospace & Defense', '6'=>' Consulting', '9'=>' Education', '8'=>' Engineering', '1'=>'Finance, Accounting, Banking, & Insurance', '15'=>' High Tech', '7'=>' Human Resources', '10'=>' Manufacturing',  '4'=>' Media & Entertainment', '22'=>' Non-profit', '63'=>' Retail & Consumer Products','26'=>' Sales', '0'=>' Other'}
    
    %w[hiring reviews].each{|w| params[w.to_s] = false }
    @IID_MAP.keys.each{|k| params["iid_" + k.to_s] = true }
    
    @employers = Employer.find(:all, :order => 'created_at desc', :limit => 8)
  end
  
  def filter_employers
    @IID_MAP = {'2'=>' Administrative & Clerical', '3'=>' Advertising & Marketing', '31'=>' Aerospace & Defense', '6'=>' Consulting', '9'=>' Education', '8'=>' Engineering', '1'=>'Finance, Accounting, Banking, & Insurance', '15'=>' High Tech', '7'=>' Human Resources', '10'=>' Manufacturing',  '4'=>' Media & Entertainment', '22'=>' Non-profit', '63'=>' Retail & Consumer Products','26'=>' Sales', '0'=>' Other'}
    @keyword = params[:filter_keyword]
    
    @employers =  Employer.filter(@keyword, params, @IID_MAP)
    render :partial => 'filtered_employers', :layout => false
  end


  # ===== displays =====
  
  def employer
    @display_right = true
    
    @css_sheet = 'homepage'
    @employer = Employer.find(params[:id])
    @page_title = @employer.company_name + " Internships and Reviews"
    
    logos = Dir.glob('public/logos/' + @employer.id.to_s + '*')
    @logo_filename = ((@employer.logo == 1 and logos != []) ? logos[0][6..-1] : nil)    
  end
  
  def internship
    @display_right = true
    
    @css_sheet = 'homepage'
    @internship = Internship.find(params[:id])
    @employer = @internship.employer
    @page_title = @internship.title + " Internship at " + @employer.company_name
  end
  
end
