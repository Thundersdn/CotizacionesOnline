class GestionController < ApplicationController

def listados
	


end

def mostrarListado
	@cli = Cliente.all
	@us = Usuario.all
	@cots = Cotizacion.all
	
	case params[:modo]
	when "1"

	end
end

def informes

end

end
