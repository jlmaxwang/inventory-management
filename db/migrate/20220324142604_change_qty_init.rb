class ChangeQtyInit < ActiveRecord::Migration[6.1]
  def change
    change_column :powders, :qty_init, :integer, default: 0
  end
end
