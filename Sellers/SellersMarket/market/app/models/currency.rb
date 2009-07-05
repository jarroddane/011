class Currency < ActiveRecord::Base
  
  
	has_many :invoices, :dependent => :destroy
	has_many :employees, :dependent => :destroy

	has_permissions

end
