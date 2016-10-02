# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161002173859) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clientes", force: :cascade do |t|
    t.string   "rut"
    t.string   "nombres"
    t.string   "direccion"
    t.string   "ciudad"
    t.string   "comuna"
    t.string   "telefono"
    t.string   "fax"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cotizacions", force: :cascade do |t|
    t.string   "estado"
    t.datetime "fecha"
    t.integer  "validez"
    t.string   "forma_de_pago"
    t.string   "cliente_id"
    t.integer  "usuario_id"
    t.integer  "total_neto"
    t.integer  "descuentos"
    t.integer  "subtotal"
    t.integer  "iva"
    t.integer  "total"
    t.string   "observacion"
    t.string   "informe_pago"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "producto_cotizacions", force: :cascade do |t|
    t.integer  "producto_id"
    t.integer  "cotizacion_id"
    t.integer  "cantidad"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "productos", force: :cascade do |t|
    t.integer  "codigo"
    t.string   "descripcion"
    t.integer  "valor_unitario"
    t.integer  "stock"
    t.string   "estado"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "descuento"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string   "rut"
    t.string   "password"
    t.integer  "privilegios"
    t.datetime "ultimo_login"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "salt"
    t.string   "nombre"
    t.string   "password_digest"
  end

end
