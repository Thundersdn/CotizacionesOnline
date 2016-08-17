class Producto < ActiveRecord::Base
  self.primary_key = "codigo"
  has_many :producto_cotizacions
  has_many :cotizacions, through: :producto_cotizacions
end
