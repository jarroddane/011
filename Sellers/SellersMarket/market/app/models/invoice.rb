class Invoice < ActiveRecord::Base
  
  TRANSACTION_TYPES = [ 
    
    [ "Credit Card", "credit"],
    [ "Debit Card", "debit" ],
    [ "Gift Card", "gift" ],
    [ "Money Order", "money" ],
    [ "Paypal", "paypal" ],
    [ "Check", "check" ]
    
    
    
    ]
  
  
  validates_presence_of :name, :address, :email, :transaction_type
  validates_inclusion_of :transaction_type, :in => TRANSACTION_TYPES.map {|disp, value| value}
  
  has_many :line_items
  
  
  def line_items_from_basket_addition(basket)
  	basket.items.each do |item|
  	   li = LineItem.through_basket_item(item)
  	   line_items << li 
  	end
  end
  
end
