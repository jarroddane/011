module WarehouseHelper


  	def div_disappear_if(condition, attributes = {}, &block)
  	    if condition
  		       attributes["style"] = "display: none"
  	    end

  	    content_tag("div", attributes, &block)
  	   end

  end

