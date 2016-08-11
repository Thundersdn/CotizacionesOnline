class CreateUsuarios < ActiveRecord::Migration
  def change
    drop_table :usuarios
    create_table :usuarios do |t|
      t.string :rut
      t.string :nombre
      t.string :password
      t.string :salt
      t.integer :privilegios
      t.datetime :ultimo_login

      t.timestamps null: false
    end

  end
end
