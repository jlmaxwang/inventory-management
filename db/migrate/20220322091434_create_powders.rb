class CreatePowders < ActiveRecord::Migration[6.1]
  def change
    create_table :powders do |t|
      t.string :name
      t.string :pin_yin
      t.decimal :price_bulk
      t.decimal :price_retail
      t.integer :qty_init
      t.integer :qty_import
      t.integer :qty_export
      t.string :location
      t.string :comment

      t.timestamps
    end
  end
end
