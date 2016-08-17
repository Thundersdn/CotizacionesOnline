class Cotizacion < ActiveRecord::Base
  has_many :producto_cotizacions, dependent: :destroy
  has_many :productos, through: :producto_cotizacions

end
