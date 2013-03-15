class GeneralMailer < ActionMailer::Base
  
  def contact_us(name, topic, email, message)
    subject    'Support Issue - YouIntern.com (contact us)'
    recipients 'support@youintern.com'
    from       'support@youintern.com'
    sent_on    Time.now
    
    body       :name => name, :topic => topic, :email => email, :message => message
  end
  
  def partner(name, title, org, phone, email, url)
    subject     'Partnership request'
    recipients  'notifications@youintern.com'
    from        'support@youintern.com'
    sent_on     Time.now
    
    body        :name => name, :title => title, :org => org, :phone => phone, :email => email, :url => url
  end
  
  def interested(employer_name, name, email, message)
    subject    'Interested in Employer - YouIntern.com (interested)'
    recipients 'notifications@youintern.com'
    from       'support@youintern.com'
    sent_on    Time.now
    
    body       :employer_name => employer_name, :name => name, :email => email, :message => message
  end

  def student_contacts(student, message, contact_emails)
    subject     'Referred contacts from YouIntern'
    recipients  'notifications@youintern.com'
    from        'support@youintern.com'
    sent_on     Time.now
    
    body        :student => student, :message => message, :contact_emails => contact_emails
  end
  
  def employer_contacts(employer, message, contact_emails)
    subject     'Referred contacts from employer'
    recipients  'notifications@youintern.com'
    from        'support@youintern.com'
    sent_on     Time.now

    body        :employer => employer, :message => message, :contact_emails => contact_emails
  end
  
end
