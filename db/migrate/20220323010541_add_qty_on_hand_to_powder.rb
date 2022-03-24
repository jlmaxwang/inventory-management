class AddQtyOnHandToPowder < ActiveRecord::Migration[6.1]
  def change
    add_column :powders, :qty_onhand, :integer, default: 0
  end
end
