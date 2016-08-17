class CreateProductoCotizacions < ActiveRecord::Migration
  def change
    create_table :producto_cotizacions do |t|
      t.integer :producto_id
      t.integer :cotizacion_id
      t.integer :cantidad

      t.timestamps null: false
    end
  end
end
