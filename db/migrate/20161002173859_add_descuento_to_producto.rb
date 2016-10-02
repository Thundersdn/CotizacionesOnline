class AddDescuentoToProducto < ActiveRecord::Migration
  def change
    add_column :productos, :descuento, :integer
  end
end
