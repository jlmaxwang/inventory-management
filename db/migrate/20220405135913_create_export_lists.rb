class CreateExportLists < ActiveRecord::Migration[6.1]
  def change
    create_table :export_lists do |t|
      t.references :powder, null: false, foreign_key: true
      t.integer :export_qty
      t.timestamps
    end
  end
end
