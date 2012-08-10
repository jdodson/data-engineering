class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name, :null => false
      t.decimal :price, :null => false

      t.timestamps
    end
  end
end
