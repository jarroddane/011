class BasketItem

attr_reader :product, :quantity

 def initialize(product)
  @product = product
  @quantity = 1
 end

 def quantity_increment
  @quantity += 1 
 end

 def label
  @product.label
 end

 def price
  @product.price * @quantity
 end

end