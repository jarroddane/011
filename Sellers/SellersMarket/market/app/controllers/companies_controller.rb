class CompaniesController < ApplicationController
 
    
    make_resourceful do
  	  actions :all

  	response_for :show do
  	   redirect_to :controller => 'charts', :action => 'company', :id => params[:id]
             end
           end


  # make_resourceful collection accessor method needs to be overridden

  	def current_objects
  	   @current_objects = Company.all_with_customer
  	end