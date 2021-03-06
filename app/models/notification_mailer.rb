class NotificationMailer < ActionMailer::Base
  
  # ===== registration =====
  
  def registered_student(student)
    subject    'New student registered - ' + student.username.to_s
    recipients 'notifications@youintern.com'
    from       'YouIntern@youintern.com'
    sent_on    Time.now
    
    body       :student => student
  end
  
  def registered_employer(employer)
    subject    'New employer registered - ' + employer.username.to_s
    recipients 'notifications@youintern.com'
    from       'YouIntern@youintern.com'
    sent_on    Time.now
    
    body       :employer => employer
  end
  
  # ===== application =====
  
  def applied(student, internship)
    subject    'Student ' + student.username.to_s + ' applied for internship'
    recipients 'notifications@youintern.com'
    from       'YouIntern@youintern.com'
    sent_on    Time.now

    body       :student => student, :internship => internship
  end

  def applynotice(student, internship, details)
    subject    'Student ' + student.username.to_s + ' applied for internship'
    recipients internship.employer.rep_email
    from       'YouIntern@youintern.com'
    sent_on    Time.now

    body       :student => student, :internship => internship, :details => details
  end
  
  # ===== other =====
  
  def posted(employer, internship)
    subject    'Employer ' + employer.company_name.to_s + ' posted internship'
    recipients 'notifications@youintern.com'
    from       'YouIntern@youintern.com'
    sent_on    Time.now

    body       :employer => employer, :internship => internship
  end
  
  def resume(filename)
    subject     'Uploaded resume'
    recipients  'notifications@youintern.com'
    from        'YouIntern@youintern.com'
    sent_on     Time.now
    
    body        :filename => filename
  end
  
  def tester
    subject     'testing html emails'
    recipients  ''
    from        'YouIntern@youintern.com'
    sent_on     Time.now
    content_type "text/html"
  end
  
end
