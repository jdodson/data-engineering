class CreateInventories < ActiveRecord::Migration
  def change
    create_table :inventories do |t|
      t.references :merchant, :null => false
      t.references :item, :null => false

      t.timestamps
    end
  end
end
