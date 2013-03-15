class EmployerController < ApplicationController
  before_filter {|c| c.send(:authorize, 'employer')}
  
  def sub_layout
    "employer"
  end
  
  # ====== home, edit info ======
  
  def home
    @employer = Employer.find_by_id(session[:user_id])
    @page_title = @employer.company_name + " Home Page"
    
    logos = Dir.glob('public/logos/' + @employer.id.to_s + '*')
    @logo_filename = ((@employer.logo == 1 and logos != []) ? logos[0][6..-1] : nil)    
  end

  def edit_info
    @employer = Employer.find(params[:id])
    @page_title = @employer.company_name + " Home Page"
    
    if @employer != Employer.find_by_id(session[:user_id])
      flash[:notice] = 'You don\'t have access to that employer!'
      redirect_to(:action => 'home') and return
    end
    
    @IID_MAP = {'2'=>' Administrative & Clerical', '3'=>' Advertising & Marketing', '31'=>' Aerospace & Defense', '6'=>' Consulting', '9'=>' Education', '8'=>' Engineering', '1'=>'Finance, Accounting, Banking, & Insurance', '15'=>' High Tech', '7'=>' Human Resources', '10'=>' Manufacturing',  '4'=>' Media & Entertainment', '22'=>' Non-profit', '63'=>' Retail & Consumer Products','26'=>' Sales', '0'=>' Other'}

    if request.post? and @employer.update_attributes(params[:employer])
      flash[:notice] = "Account information for #{@employer.company_name} updated"
      redirect_to(:controller => "employer", :action => "home")
    end
  end
  
  # ====== add/edit internships ======
  # contains ugly checkbox hack
  
  def add_internship
    @employer = Employer.find_by_id(session[:user_id])
    @page_title = @employer.company_name + " Home Page"
    
    @internship = Internship.new(params[:internship])
    @internship.cb_string = (params[:cb1] ? '1' : '0') + (params[:cb2] ? '1' : '0') + (params[:cb3] ? '1' : '0') + (params[:cb4] ? '1' : '0') + (params[:cb5] ? '1' : '0') + (params[:cb6] ? '1' : '0') + (params[:cb7] ? '1' : '0') + (params[:cb8] ? '1' : '0')
    @internship.employer_id = Employer.find_by_id(session[:user_id]).id
    @internship.featured = -1
    
    if request.post? and @internship.save
      NotificationMailer.deliver_posted(@employer, @internship)
      RegistrationMailer.deliver_posted_confirm(@employer.rep_email, @employer.company_name, @internship.title)
      flash[:notice] = "Internship created"
      
      redirect_to(:action => "feature", :id => @internship)
    end
  end
  
  def edit_internship
    @internship = Internship.find(params[:id])
    @employer = Employer.find_by_id(session[:user_id])
    
    @cb_curr = []
    for i in (0..7)
      @cb_curr << (@internship.cb_string.to_s[i..i]=='1' ? true : false)
    end
    
    if @internship.employer != Employer.find_by_id(session[:user_id])
      flash[:notice] = 'You don\'t have access to that internship!'
      redirect_to(:action => 'home') and return
    end
    
    if request.post? 
      @internship.cb_string = (params[:cb1] ? '1' : '0') +     (params[:cb2] ? '1' : '0') +     (params[:cb3] ? '1' : '0') +     (params[:cb4] ? '1' : '0') +     (params[:cb5] ? '1' : '0') +     (params[:cb6] ? '1' : '0') +     (params[:cb7] ? '1' : '0') +     (params[:cb8] ? '1' : '0')
      @internship.update_attributes(params[:internship])
      flash[:notice] = "Internship details for #{@internship.title} updated"

      redirect_to(:action => 'home')
    end
  end
  
  def delete_internship
    @internship = Internship.find(params[:id])
    
    if @internship.employer != Employer.find_by_id(session[:user_id])
      flash[:notice] = 'You don\'t have access to that internship!'
      redirect_to(:action => 'home') and return
    end
    
    Internship.find(params[:id]).destroy
    flash[:notice] = "Internship deleted"
    redirect_to(:action => 'home')
  end
  
  # ====== pricing, logos, resumes ======
  
  def feature
    @internship = Internship.find(params[:id])
  end
  
  def pricing
    e = Employer.find_by_id(session[:user_id])
    @internships = e.internships
  end
  
  def upload_logo
    @employer = Employer.find_by_id(session[:user_id])
    @suggested = @employer.company_name.gsub(" ","_") + "_logo"
  end
  
  def save_logo
    if request.post?
      @employer = Employer.find_by_id(session[:user_id])
      original = params[:datafile].original_filename
      
      if original[-3..-1] != 'jpg' and original[-3..-1] != 'png'
        flash[:notice] = "You must select a .jpg or .png file. (If you don't have one, send us an email with the logo attached and we'll convert it and upload it for you.)"
        redirect_to(:controller => "employer", :action => "upload_logo") and return
      end
      
      old_logo = Dir.glob('public/logos/' + @employer.id.to_s + '*')
      File.delete(old_logo[0]) if old_logo != []
      
      path = File.join("public/logos", session[:user_id].to_s + params[:filename].to_s + \
        Time.now.strftime('%Y%m%d').to_s + params[:datafile].original_filename[-4..-1])
      
      File.open(path, "wb"){|f| f.write(params[:datafile].read)}
      Employer.find_by_id(session[:user_id]).update_attributes(:logo => 1)
      
      flash[:notice] = "You successfully uploaded a logo."
      redirect_to(:controller => "employer", :action => "home")
    end
  end
  
  def download_resume
    if request.post?
      student_id = params[:student_id]
      resumes = Dir.glob('public/resumes/' + student_id.to_s + '_*')
      
      send_file(resumes[0], :disposition => 'attachment')      
    end
  end
    
end
