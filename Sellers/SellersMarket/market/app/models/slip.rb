class Slip < ActiveRecord::Base
  
  belongs_to :currency
  belongs_to :company
  has_many :line_items, :class_name => 'Job', :dependent => :nullify

  has_permissions


end
