class CreateShippings < ActiveRecord::Migration
  def self.up
    create_table :shippings do |t|
      t.string :name
      t.string :location
      t.decimal :cost
      t.date :shipped
      t.date :received

      t.timestamps
    end
  end

  def self.down
    drop_table :shippings
  end
end
