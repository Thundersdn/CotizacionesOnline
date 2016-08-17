class ProductoCotizacion < ActiveRecord::Base
  belongs_to :producto
  belongs_to :cotizacion
end
