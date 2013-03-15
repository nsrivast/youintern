class RegistrationMailer < ActionMailer::Base
  
  # ---
  # default registration confirmations
  
  def student(student)
    subject    'Registration confirmed at YouIntern.com!'
    recipients student.email
    from       'YouIntern@youintern.com'
    sent_on    Time.now
    
    body       :student => student
  end

  def employer(employer)
    subject    'Registration confirmed at YouIntern.com!'
    recipients employer.rep_email
    from       'YouIntern@youintern.com'
    sent_on    Time.now
    
    body       :employer => employer
  end
  
  # ---
  # account management
  
  def forgot_password(email, new_pass, username)
    subject    'Your temporary password'
    recipients email
    from       'support@youintern.com'
    sent_on    Time.now
    
    body       :new_pass => new_pass, :username => username
  end
  
  # ---
  # confirmations for uploading, applying, posting
  
  def resume_confirm(email, username, filename)
    subject     'You have uploaded your resume to YouIntern'
    recipients  email
    from        'support@youintern.com'
    sent_on     Time.now
    
    body        :username => username, :filename => filename
  end
  
  def posted_confirm(email, company, internship)
    subject     'You\'ve successfully posted an internship to YouIntern'
    recipients  email
    from        'support@youintern.com'
    sent_on     Time.now
    
    body        :company => company, :internship => internship
  end
  
  def applied_confirm(email, username, internship, company)
    subject     'You have applied for an internship through YouIntern!'
    recipients  email
    from        'support@youintern.com'
    sent_on     Time.now
    
    body        :username => username, :internship => internship, :company => company
  end
  
  # ---
  # one-time sendouts for reregistering old users
  
  def reregister(email, new_pass, username)
    subject     'Proud to Announce: the NEW YouIntern.com'
    recipients  email
    from        'YouIntern@youintern.com'
    sent_on     Time.now
    
    body        :username => username, :email => email, :new_pass => new_pass
  end

  def reregister_employer(email, new_pass, username, company_name)
    subject     'YouIntern.com 2.0 is LIVE -- post your new internships!'
    recipients  email
    from        'YouIntern@youintern.com'
    sent_on     Time.now
    
    body        :username => username, :email => email, :new_pass => new_pass, :company_name => company_name
  end
end
