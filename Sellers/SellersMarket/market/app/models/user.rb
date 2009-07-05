class User < ActiveRecord::Base
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  attr_accessor :password_confirmation
  validates_confirmation_of :password
  
  validate :password_is_not_blank
  
  
  # The password is a virtual attribute
  
  def password 
  @password 
  end 
  
  def password=(pass) 
  @password = pass
  
  return if pass.blank? 
  make_new_salt 
  self.hashed_password = User.encrypted_password(self.password, self.salt) 
  end
  
  
  private
  
  def password_is_not_blank
    errors.add(:password, "Credentials Missing- Pass") if hashed_password.blank?
  end

  def make_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end

  def self.encrypted_password(password, salt) 
    string_to_hash = password + "wibble" + salt 
    Digest::SHA1.hexdigest(string_to_hash) 
end


end
