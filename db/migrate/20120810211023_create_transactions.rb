class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :name, :count, :default => 0

      t.references :customer, :null => false
      t.references :item, :null => false

      t.timestamps
    end

    add_index :transactions, [ :customer_id, :item_id ]
  end
end
