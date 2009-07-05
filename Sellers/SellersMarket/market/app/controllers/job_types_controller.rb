class JobTypesController < ApplicationController


  	make_resourceful do
  	   actions :all

  	response_for :show do
  	   redirect_to job_type_path
  	end
  end
  
end