class CreateCotizacions < ActiveRecord::Migration
  def change
    create_table :cotizacions do |t|
      t.string :estado
      t.datetime :fecha
      t.integer :validez
      t.string :forma_de_pago
      t.string :cliente_id
      t.integer :usuario_id
      t.integer :total_neto
      t.integer :descuentos
      t.integer :subtotal
      t.integer :iva
      t.integer :total
      t.string :observacion
      t.string :informe_pago

      t.timestamps null: false
    end
  end
end
