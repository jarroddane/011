class Employee < ActiveRecord::Base
  
  

  	belongs_to :currency
  	has_many :companies, :dependent => :destroy
  	has_many :invoices, :dependent => :destroy

  	has_permissions

end
