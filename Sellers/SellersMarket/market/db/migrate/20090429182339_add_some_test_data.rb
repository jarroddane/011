class AddSomeTestData < ActiveRecord::Migration
  

  def self.up 
    
  Product.delete_all 
  
  Product.create(:label => 'Hewlitt Packard All in One Printer', :description => 
  %{<p> 
  This prinetr will work great in the office, at home and even on the go.  If you are looking for the perfect solution for everyday printing, then this is your best bet 
  </p>}, 
  
  :image_url => '/images/hp_printer_11209.jpg', :video_url => 'videos/hp_printer_11209.avi', :price => 69.99) 
  # . . . 
  
  Product.create(:label => 'Apple iPhone 3G',
    :description =>
    %{<p>
       This phone/mini computer is the best companion for an on the go business type.  With more features than you can shake a stick at, this mobile will stand the test of time.  Guaranteed !
    </p>},
  :image_url => '/images/iPhone_3G.jpg', :video_url => 'videos/iPhone_3G.flv', :price => 28.50)
  # . . .
  
  
  end
  
   
  def self.down 
    
  Product.delete_all 
  
  end 
end 
