class DataEntry < ActiveRecord::Base
  
  
	belongs_to :job
	
	has_permissions
	
	
end
