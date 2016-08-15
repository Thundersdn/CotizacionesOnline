class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.string :rut
      t.string :nombres
      t.string :direccion
      t.string :ciudad
      t.string :comuna
      t.string :telefono
      t.string :fax
      t.string :email

      t.timestamps null: false
    end
  end
end
