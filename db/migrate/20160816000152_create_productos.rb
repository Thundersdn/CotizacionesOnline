class CreateProductos < ActiveRecord::Migration
  def change
    create_table :productos do |t|
      t.integer :codigo
      t.string :descripcion
      t.integer :valor_unitario
      t.integer :stock
      t.string :estado

      t.timestamps null: false
    end
  end
end
