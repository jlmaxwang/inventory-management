class ChangeQtyImport < ActiveRecord::Migration[6.1]
  def change
    change_column :powders, :qty_import, :integer, default: 0
  end
end
