class Cartero < ApplicationMailer
	default from: "notificaciones@CotizacionesOnline.cl"
	def cotizacionMail(cot)
		@cot = cot
		@cli = Cliente.find(@cot.cliente_id)
		@usu = Usuario.find(@cot.usuario_id)
		@prodsCot = @cot.productos
		mail(to: @cli.email , subject: 'Cotizacion')
	end
end
