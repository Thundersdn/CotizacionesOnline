class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :rut
      t.string :nombre
      t.string :password_digest
      t.string :salt
      t.integer :privilegios
      t.datetime :ultimo_login

      t.timestamps null: false
    end

  end
end
