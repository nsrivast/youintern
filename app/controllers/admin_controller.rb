class AdminController < ApplicationController
  before_filter {|c| c.send(:authorize, 'admin')}

  def sub_layout
    "student"
  end
  
  def home
    @admin = Admin.find_by_id(session[:user_id])
  end
  
  def save_logo
    if request.post?
      @employer = Employer.find_by_id(params[:employer_id])
      original = params[:datafile].original_filename
      
      if original[-3..-1] != 'jpg' and original[-3..-1] != 'png'
        flash[:notice] = "You must select a .jpg or .png file."
        redirect_to(:controller => "admin", :action => "upload_logo") and return
      end
      
      old_logo = Dir.glob('public/logos/' + @employer.id.to_s + '*')
      File.delete(old_logo[0]) if old_logo != []
      
      path = File.join("public/logos", params[:employer_id].to_s + params[:filename].to_s + \
        Time.now.strftime('%Y%m%d').to_s + params[:datafile].original_filename[-4..-1])
      
      File.open(path, "wb"){|f| f.write(params[:datafile].read)}
      
      e = Employer.find_by_id(params[:employer_id])
      e.update_attributes(:logo => 1) if !e.nil?
      
      flash[:notice] = "You successfully uploaded a logo for employer: " + e.company_name.to_s + "."
      redirect_to(:controller => "admin", :action => "upload_logo")
    end
  end
  
  def stats
    @emp_count = Employer.count(:all)
    @stud_count = Student.count(:all)
    @int_count = Internship.count(:all)
  end
end
