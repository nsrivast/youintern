require_dependency "search"
require 'digest/sha1'

class Student < ActiveRecord::Base

  has_many :reviews
  has_and_belongs_to_many :internships
  
  validates_presence_of :username, :email, :first_name, :last_name
  validates_uniqueness_of :username, :email
  
  attr_protected :id, :salt
  attr_accessor :password_confirmation
  validates_confirmation_of :password
  
  searches_on :all
	
  def reregister
    new_pass = Student.random_string(10)
    
    self.password = new_pass
    self.password_confirmation = new_pass
    self.save
    
    RegistrationMailer.deliver_reregister(self.email, new_pass, self.username)
    true
  end
  
  def send_new_password
    new_pass = Student.random_string(10)
    
    self.password = new_pass
    self.password_confirmation = new_pass
    self.save
    
    RegistrationMailer.deliver_forgot_password(self.email, new_pass, self.username)
    true
  end
  
  def self.random_string(len)
    newpass = ""
    len.times { newpass << (i = Kernel.rand(62); i += ((i < 10) ? 48 : ((i < 36) ? 55 : 61 ))).chr }
    newpass
  end
  
  def self.authenticate(name, password)
    user = Student.find_by_username(name)
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
    self.hashed_password = Student.encrypted_password(pwd, self.salt)
  end
  
  def self.latest(n)
    Student.find(:all, :order => 'created_at DESC', :limit => n)
  end
  
  # ===== private =====
  private
  
  def self.encrypted_password(password, salt)
    string_to_hash = password.to_s + "scroofy" + salt.to_s
    Digest::SHA1.hexdigest(string_to_hash)
  end
  
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

end
