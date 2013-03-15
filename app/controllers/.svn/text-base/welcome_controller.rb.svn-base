require 'net/http'
require 'open-uri'
require 'rexml/document'

class WelcomeController < ApplicationController
  
  def sub_layout
    "welcome"
  end
  
  def index
    # flash[:notice]
    @css_sheet = 'homepage'
  end
  
  # ====== content ======
  
  def blog
    @css_sheet = 'homepage'
    @blog_content = get_blog_content
  end
  
  def featured
    @css_sheet = 'homepage'
    @featured_posts = Internship.featured(100)
  end
  
  def latest_students
    @css_sheet = "homepage"
    @latest_students = Student.find(:all, :limit => 10, :order => "created_at DESC")
  end
  
  def latest_internships
    @css_sheet = "homepage"
    @latest_internships = Internship.latest(10)
  end
  
  # ====== bottom links ======
  
  def contact
    @css_sheet = 'homepage'
    @page_title = "Internships and Reviews - Contact Us"
    
    if request.post?
      GeneralMailer.deliver_contact_us(params[:name], params[:topic], params[:email], params[:message])
      flash[:notice] = "Message delivered! Thank you for your feedback - we'll get back to you shortly."
      redirect_to(:action => 'index')
    end
  end
  
  def partner
    @css_sheet = 'homepage'
    @page_title = "Partner with YouIntern"
    
    if request.post?
      GeneralMailer.deliver_partner(params[:name], params[:title], params[:org], params[:phone], params[:email], params[:url])
      flash[:notice] = "Message delivered! Thank you for your interest - we'll get back to you shortly."
      redirect_to(:action => 'partners')
    end
  end
  
  def interested
    @css_sheet = 'homepage'
    
    if request.post?
      GeneralMailer.deliver_interested(params[:employer_name], params[:name], params[:email], params[:message])
      flash[:notice] = "The employer has been notified of your interest."
      redirect_to(:action => 'index')
    else
      @name = Employer.find(params[:id]).company_name
    end
  end
  
  # ====== registration ======

  def go_home
    redirect_to(:controller => session[:user_type], :action => 'home') and return if session[:user_type]
    
    flash[:notice] = "Please log in or register to create a portfolio."
    redirect_to(:controller => 'welcome', :action => 'index')
  end
   
  def register_as_student    
    @page_title = "Internships and Reviews - Register Now"
    
    @student = Student.new(params[:student])
    if request.post? and @student.save
      session[:user_id], session[:user_type], session[:username] = @student.id, "student", @student.username
      
      NotificationMailer.deliver_registered_student(@student)
      RegistrationMailer.deliver_student(@student)
      
      flash[:notice] = "Student #{@student.username} created"
      redirect_to(:action => "student_contacts")
    end
  end
  
  def student_contacts
    @student = Student.find_by_id(session[:user_id])
    @default_message = "I recently registered at YouIntern and think it can help you, too. YouIntern is the web's best resource to find a new internship, write a review of your last internship, or give your career a boost with some expert advice from industry professionals.  They reach out directly to employers to provide internship opportunities for students, and everything is obviously free.  
    
    Give it a look -- hope it helps you out."
    
    if request.post?
      GeneralMailer.deliver_student_contacts(@student, params[:message], params[:contact_emails])
      flash[:notice] = "Thank you!"
      redirect_to(:controller => 'student', :action => 'home')
    end
  end
  
  def register_as_employer
    @IID_MAP = {'2'=>' Administrative & Clerical', '3'=>' Advertising & Marketing', '31'=>' Aerospace & Defense', '6'=>' Consulting', '9'=>' Education', '8'=>' Engineering', '1'=>'Finance, Accounting, Banking, & Insurance', '15'=>' High Tech', '7'=>' Human Resources', '10'=>' Manufacturing',  '4'=>' Media & Entertainment', '22'=>' Non-profit', '63'=>' Retail & Consumer Products','26'=>' Sales', '0'=>' Other'}
    @page_title = "Internships and Reviews - Register Now"
    
    @employer = Employer.new(params[:employer])
    if request.post? and @employer.save
      session[:user_id], session[:user_type], session[:username] = @employer.id, "employer", @employer.username
      
      NotificationMailer.deliver_registered_employer(@employer)
      RegistrationMailer.deliver_employer(@employer)
      
      flash[:notice] = "Employer #{@employer.username} created"
      redirect_to(:action => "employer_contacts")
    end
  end
  
  def employer_contacts
    @employer = Employer.find_by_id(session[:user_id])
    @default_message = "I just finished registering with YouIntern and think it can help you, too.  YouIntern is a new web resource that helps you search for eager and capable interns.  You can quickly post your open internships for YouIntern's thousands of student users to see, and YouIntern manages the application process through Your Portfolio. No more paper resumes or time-consuming internship processes.  
    
    Give it a shot -- hope it helps you out."
    
    if request.post?
      GeneralMailer.deliver_employer_contacts(@employer, params[:message],params[:contact_emails])
      flash[:notice] = "Thank you!"
      redirect_to(:controller => 'employer', :action => 'home')
    end
  end
  
  # ====== login, password ======
  
  def login
    @page_title = "Internships and Reviews - Login"
    
    if params[:username].blank? or params[:password].blank?
      flash[:notice] = "Please enter both a username and password to login."
      redirect_to(:controller => 'welcome', :action => 'index') and return
    end
    
    session[:user_id], session[:user_type], session[:username] = nil, nil, nil
    
    ["student", "employer", "admin"].each do |user_type|
      user = user_type.classify.constantize.authenticate(params[:username], params[:password])
      if user
        session[:user_id], session[:user_type], session[:username] = user.id, user_type, user.username
        flash[:notice] = "Logged in as " + user.username
        redirect_to(:controller => user_type, :action => "home") and return
      end
    end

    flash[:notice] = "Wrong username or password. Please try again. If you're having trouble, feel free to contact us at support@youintern.com"
    redirect_to(:controller => "welcome", :action => 'index') and return
  end
    
  def forgot_student_password
    student = Student.find_by_email(params[:email])
    
    if student
      student.send_new_password
      flash[:notice] = "A temporary password has been sent to " + params[:email] + " - follow the link in the email to reset it."
      redirect_to(:action => 'index') and return
    end
    
    flash[:notice] = "We can't recognize that email in our databases. Email us if you require personal help."
    redirect_to :action => 'forgot_password' and return
  end
  
  def forgot_employer_password
    employer = Employer.find_by_rep_email(params[:email])
    
    if employer
      employer.send_new_password
      flash[:notice] = "A temporary password has been sent to " + params[:email] + " - follow the link in the email to reset it."
      redirect_to(:action => 'index') and return
    end

    flash[:notice] = "We can't recognize that email in our databases. Email us if you require personal help."
    redirect_to :action => 'forgot_password' and return
  end

  def change_password
    if request.post? and params[:new_password] == params[:new_password_confirm]
  
      student = Student.authenticate(params[:username], params[:old_password])
      if student
        student.password = params[:new_password]
        student.password_confirmation = params[:new_password]
        student.save
      end
      
      employer = Employer.authenticate(params[:username], params[:old_password])
      if employer
        employer.password = params[:new_password]
        employer.password_confirmation = params[:new_password_confirm]
        employer.save
      end
      
      if employer or student
        flash[:notice] = "Password successfully changed!"
        redirect_to(:action => 'index') and return
      else
        flash[:notice] = "Incorrect password for user " + params[:username]
        redirect_to(:action => 'change_password') and return
      end
      
    elsif request.post?
      flash[:notice] = "Confirm your new password correctly, please."
      redirect_to(:action => 'change_password')
    end
  end
  
  def logout
    session[:user_id], session[:user_type], session[:username] = nil, nil, nil
    flash[:notice] = "Logged off"
    redirect_to(:controller => "welcome", :action => "index")
  end
  
protected
  
  def get_blog_content
    feed_url = 'http://carmonize.blogspot.com/feeds/posts/default'
    output = []
    open(feed_url) do |http|
      doc = REXML::Document.new http.read
      
      doc.elements.each("*/entry") do |entry|
        output += [{
          :date => entry.elements["published"].text,
          :title => entry.elements["title"].text,
          :link => entry.elements["link"].attributes["href"],
          :content => entry.elements["content"].text
        }]
      end
        
    end
    output
  end

end