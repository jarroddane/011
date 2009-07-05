class WarehouseController < ApplicationController
  
  protect_from_forgery :only => [:create, :update, :destroy]
  
  def index
    
    @products = Product.find_products_to_be_sold
    @basket = get_basket
    
  end
  
  
  def add_to_basket

  product = Product.find(params[:id])
  @basket = get_basket
  @current_item = @basket.add_product(product)
  
  respond_to do |format|
  	format.js if request.xhr?
  	format.html {back_to_the_index_page}
    
  end

  rescue ActiveRecord::RecordNotFound
  logger.error("Trying to access the wrong product #{params[:id]}")
  back_to_the_index_page("Wrong Product")
 
  end

  def erase_basket

  session[:basket] = nil

  back_to_the_index_page("Your basket has been erased from the session")
 
 end
 
 
 	def finish_shopping
	
	 @basket = get_basket	
	      
	  if @basket.items.empty?
      	back_to_the_index_page("The shopping basket is now empty")
	      
	      else 
	       @invoice = Invoice.new
	  end
   end
   
   
   def save_invoice
   	   @basket = get_basket
   	   @invoice = Invoice.new(params[:invoice])
   	   @invoice.line_items_from_basket_addition(@basket)

   	if @invoice.save
   	    session[:basket] = nil
   	    back_to_the_index_page("Your invoice has been processed")

   	else
   	    render :action => 'finish_shopping'
   	end
  end
  
  # If the session hash has a value that relates to the key :basket, that specific value is immediately returned.
  #  Else, a new object (basket) is made and assigned to the session.  This new basket is then returned.
  #  Since the method is made 'private', Rails is not allowed to make it available as an action on the controller.
  
  # Private methods may not be called as actions
  
  private 

  def get_basket
    
    session[:basket] ||= Basket.new

  end
  
  
  private

  def back_to_the_index_page(alert_message = nil)
    flash[:notice] = alert_message if alert_message
    redirect_to :action => :index
  end

end
