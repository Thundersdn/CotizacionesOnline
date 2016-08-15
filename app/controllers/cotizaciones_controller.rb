class CotizacionesController < ApplicationController

  def administrar
    @clientes = Cliente.all

    respond_to do |format|
      format.html
      format.js
      format.json

    end
  end

  def selCliente
    @cliente = Cliente.find_by_rut(params[:rutCliente])

    respond_to do |format|
        format.html {redirect_to '/home'}
        format.js
        format.json {render json: @cliente}
    end
  end

end
