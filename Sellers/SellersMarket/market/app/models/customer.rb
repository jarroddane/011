require 'digest/sha1'

class Customer < ActiveRecord::Base
  
  validates_presence_of   :name
  validates_uniqueness_of :name
  
  attr_accessor  :confirm_password
  validates_confirmation_of :password
  
  validate :pass_not_nil
  
  
  def new_salt_creation
    self.salt = self.object_id.to_s + rand.to_s
  end
  
  
  def password
  	    @password
  	end

  def password=(pass)
  	 @password = pass
     return if pass.blank?
	   new_salt_creation  	  
	   self.hashed_password = Customer.password_encryption(self.password, self.salt)
  end
  	
  	
  
	def self.authentication(name, password)
	  customer = self.name_search(name)
	   if customer
	     password_expected = password_expected(password, customer.salt)
	   if customer.hashed_password != password_expected
	       customer = nil
	   end
  	end
	
	  customer
	
  end
  	
  
  private
  
  def pass_not_nil
    errors.add_to_base("The password is empty") if hashed_password.blank?
  end



  def self.password_encryption(password, salt)
    type_string_to_hash_value = password + "wibble" + salt
    Digest::SHA1.hexdigest(type_string_to_hash_value)
  end

end
