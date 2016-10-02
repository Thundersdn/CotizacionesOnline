class Producto < ActiveRecord::Base
	 	has_many :producto_cotizacions
		has_many :cotizacions, through: :producto_cotizacions
		validates :descuento, numericality:{only_integer:true, greater_than_or_equal_to:0,less_than:101}
		validates :valor_unitario, numericality:{only_integer:true, greater_than:0}
end
