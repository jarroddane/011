#---
# Excerpted from "Advanced Rails Recipes",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fr_arr for more book information.
#---
ActiveRecord::Schema.define(:version => 1) do
  create_table :conversations, :force => true do |t|
    t.column :state_machine, :string
    t.column :subject,       :string
    t.column :closed,        :boolean
  end
  
  create_table :people, :force => true do |t|
    t.column :name, :string
  end
end
