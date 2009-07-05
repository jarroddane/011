class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.string :name
      t.text :address
      t.string :email
      t.string :transaction_type, :limit => 10

      t.timestamps
    end
  end

  def self.down
    drop_table :invoices
  end
end
