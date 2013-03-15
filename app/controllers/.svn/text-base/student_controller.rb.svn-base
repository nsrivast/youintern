class StudentController < ApplicationController
  before_filter {|c| c.send(:authorize, 'student')}
  
  def sub_layout
    "student"
  end
  
  # ====== home, info ======
  
  def home
    @student = Student.find_by_id(session[:user_id])

    resumes = Dir.glob('public/resumes/' + @student.id.to_s + '_*')
    @resume_filename = ((@student.resume ==1 and resumes != []) ? resumes[0] : nil)
  end
  
  def edit_info
    @student = Student.find(params[:id])
  
    if @student != Student.find(session[:user_id])
      flash[:notice] = 'You don\'t have access to that student\'s info.'
      redirect_to :action => 'home'
    end
      
    if request.post? and @student.update_attributes(params[:student])
      flash[:notice] = "Student #{@student.username} information updated"
      redirect_to(:controller => "student", :action => "home")
    end
  end
  
  
  # ====== reviews ======
  
  def write_review
    @employers = Employer.find(:all, :order => "company_name")
    @review = Review.new(params[:review])

    @student = Student.find_by_id(session[:user_id])
    @suggested_name = @student.first_name + '\'s review of ... '
    
    if request.post?
      @review.student_id = @student.id
      @review.save
      
      flash[:notice] = "Review created"
      redirect_to(:controller => "search", :action => "employer", :id => @review.employer_id)
    end
  end

  def edit_review
    @review = Review.find(params[:id])
    
    if @review.student != Student.find(session[:user_id])
      flash[:notice] = 'You don\'t have access to that review!'
      redirect_to :action => 'home'
    end
    
    if request.post? and @review.update_attributes(params[:review])
      flash[:notice] = "Review updated!"
      redirect_to(:controller => "student", :action => "home")
    end
  end
  
  
  # ====== resume ======
  
  def download_resume
    if request.post?
      filename = params[:filename]
      send_file(filename, :disposition => 'attachment')      
    end
  end

  def upload_resume
    @student = Student.find_by_id(session[:user_id])
    @suggested = @student.last_name + "_resume"
  end
  
  def save_resume
    if request.post?
      @student = Student.find_by_id(session[:user_id])
      original = params[:datafile].original_filename
      
      if original[-3..-1] != 'doc' and original[-3..-1] != 'pdf'
        flash[:notice] = "You must select a .doc or .pdf file less than 100kB."
        redirect_to(:controller => "student", :action => "upload_resume") and return
      end
      
      old_resume = Dir.glob('public/resumes/' + @student.id.to_s + '_*')
      File.delete(old_resume[0]) if old_resume != []
      
      name = session[:user_id].to_s + '_' + params[:filename].to_s + '_' + \
        Time.now.strftime('%Y%m%d').to_s + params[:datafile].original_filename[-4..-1]
      path = File.join("public/resumes", name)
      
      File.open(path, "wb"){|f| f.write(params[:datafile].read)}
      Student.find_by_id(session[:user_id]).update_attributes(:resume => 1)
      
      NotificationMailer.deliver_resume(name)
      RegistrationMailer.deliver_resume_confirm(@student.email, @student.username, params[:filename].to_s)

      flash[:notice] = "You successfully uploaded a resume."
      redirect_to(:controller => "student", :action => "home")
    end
  end
  
  # ====== apply ======
  
  def apply
    @internship = Internship.find(params[:id])
    @student = Student.find_by_id(session[:user_id])
    
    @cb_curr = []
    for i in (0..7)
      @cb_curr << (@internship.cb_string.to_s[i..i]=='1' ? true : false)
    end
    
    if @student.resume != 1
      flash[:notice] = "You must upload a resume before applying for a job!"
      redirect_to(:action => 'home') and return
    end
    
    if request.post?
      @internship.students << @student
      
      NotificationMailer.deliver_applynotice(@student, @internship, construct_apply_notice(@internship, params))
      NotificationMailer.deliver_applied(@student, @internship)
      RegistrationMailer.deliver_applied_confirm(@student.email, @student.username, @internship.title, @internship.employer.company_name)
      flash[:notice] = "You successfully applied for the internship."
      redirect_to(:action => 'home')
    end
  end
  
protected

  def construct_apply_notice(i, params)
    s = []
    if params[:name]:  s << 'Name: ' + params[:name].to_s                   end
    if params[:email]: s << 'Email: ' + params[:email].to_s                 end
    if params[:phone]: s << 'Phone: ' + params[:phone].to_s                 end
    if params[:school]: s << 'School/College: ' + params[:school].to_s      end
    if params[:major]: s << 'Major/Concentration: ' + params[:major].to_s   end
    if params[:grad]: s << 'Graduation Year: ' + params[:grad].to_s         end
    if params[:web]: s << 'Web site: ' + params[:web].to_s                  end
    if params[:gpa]: s << 'GPA: ' + params[:gpa].to_s                       end
  
    if i.extra1 != '': s << i.extra1.to_s + ' ' + params[:extra1].to_s           end
    if i.extra2 != '': s << i.extra2.to_s + ' ' + params[:extra2].to_s           end
    if i.extra3 != '': s << i.extra3.to_s + ' ' + params[:extra3].to_s           end
    
    s
  end
end


