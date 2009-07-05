class LineItem < ActiveRecord::Base
  
  belongs_to :invoice
  belongs_to :product
  
  
  
  
	def self.through_basket_item(basket_item)
	   li = self.new
	   li.product = basket_item.product
	   li.quantity = basket_item.quantity
	   li.price_sum = basket_item.price
	   li
	end
	
end
