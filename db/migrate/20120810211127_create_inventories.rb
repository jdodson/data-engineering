class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.references :merchant, :null => false
      t.references :item, :null => false

      t.timestamps
    end

    add_index :inventories, [ :merchant_id, :item_id ], :unique => true
  end
end
