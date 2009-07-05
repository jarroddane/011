class Basket
  

  attr_reader :items



  def initialize 

    @items = []

  end
  
  


    def add_product(product)
      
      current_item = @items.find {|item| item.product == product}
      
      if current_item
        current_item.quantity_increment
        
      else
        
        current_item = BasketItem.new(product)
        		@items << current_item
      end
      
      current_item
      
    end
    
    
    def price_sum
      
      @items.sum { |item| item.price }

  end
  
  
  def number_of_items
    
     @items.sum { |item| item.quantity }
  end

end