class Product < ActiveRecord::Base
  
  has_many :line_items
  
  
  def self.find_products_to_be_sold
     find(:all, :order => "label")
  end
  
  
  validates_presence_of :label, :description, :image_url
  
  validates_numericality_of :price 
  
  validates_uniqueness_of :label
  
  
  
  validates_format_of :image_url, :with => %r{\.(jpg|gif|png)$}i, 
  :message => 'You have to add a URL for a JPG, GIF ' + 'or PNG image.(jpg|gif|png)'


  validates_format_of :video_url, 
  :with => %r{\.(avi|flv|wmv)$}i, 
  :message => 'You have to add a URL for a AVI, FLV ' + 'or WMV video.(avi|flv|wmv)'
  
  
  
  protected
  
  def price_has_to_be_more_than_a_penny
    errors.add(:price, 'has to be more than a penny') if price.nil? || price < 0.01
    
  end
  
  
end
