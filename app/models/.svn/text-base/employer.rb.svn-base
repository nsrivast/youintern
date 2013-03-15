require_dependency "search"
require 'digest/sha1'

class Employer < ActiveRecord::Base
  
  has_many :internships
  has_many :reviews
  
  validates_presence_of :username, :company_name, :company_iid, :rep_first_name, :rep_last_name, :rep_email
  validates_uniqueness_of :username, :company_name
    
  attr_protected :id, :salt
  attr_accessor :password_confirmation
  validates_confirmation_of :password
  
  def reregister
    new_pass = Employer.random_string(10)
    
    self.password = new_pass
    self.password_confirmation = new_pass
    self.save
    
    RegistrationMailer.deliver_reregister_employer(self.rep_email, new_pass, self.username, self.company_name)
    true
  end
  
  def self.random_string(len)
    newpass = ""
    len.times { newpass << (i = Kernel.rand(62); i += ((i < 10) ? 48 : ((i < 36) ? 55 : 61 ))).chr }
    newpass
  end
  
  # ===== search filters =====
  searches_on :company_name, :company_location, :company_website, :company_email, :company_about, \
    :rep_title, :rep_about, :rep_first_name, :rep_last_name, :rep_email
  
  def self.filter(ss, params, iid_map)
    
    conditions = iid_map.keys.reject{|iid| not params["iid_" + iid.to_s]
      }.collect{|iid| 'company_iid = ' + iid.to_s
      }.join(' OR ')
    conditions += ' OR company_iid is null' if params["iid_0"]
    conditions = (conditions == "" ? nil : '(' + conditions + ')')
    
    found_employers = Employer.search(ss, \
      {:conditions => conditions, :include => [:internships, :reviews], :order => 'created_at desc'})
    
    return found_employers.reject{|e| 
      (params[:hiring] ? (e.internships == []) : false) || \
      (params[:reviews] ? (e.reviews == []) : false)
      }
      
  end
  
  # ===== validation =====
  
  def send_new_password
    new_pass = Employer.random_string(10)
    
    self.password = new_pass
    self.password_confirmation = new_pass
    self.save
    
    RegistrationMailer.deliver_forgot_password(self.rep_email, new_pass, self.username)
    true
  end
  
  def self.random_string(len)
    newpass = ""
    len.times { newpass << (i = Kernel.rand(62); i += ((i < 10) ? 48 : ((i < 36) ? 55 : 61 ))).chr }
    newpass
  end
  
  def self.authenticate(name, password)
    user = Employer.find_by_username(name)
    if user
      input_password = encrypted_password(password, user.salt)
      if user.hashed_password != input_password
        user = nil
      end
    end
    user
  end
  
  def password
    @password
  end
  
  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = Employer.encrypted_password(self.password, self.salt)
  end

  # ===== private =====
  private
  
  def self.encrypted_password(password, salt)
    string_to_hash = password + "scroofy" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end
  
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  
end
