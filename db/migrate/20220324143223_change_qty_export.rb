class ChangeQtyExport < ActiveRecord::Migration[6.1]
  def change
    change_column :powders, :qty_export, :integer, default: 0
  end
end
