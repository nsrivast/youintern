require 'digest/sha1'

class Admin < ActiveRecord::Base
  
  attr_protected :id, :salt
  attr_accessor :password_confirmation
  validates_confirmation_of :password
  
  def self.authenticate(name, password)
    user = Admin.find_by_username(name)
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
