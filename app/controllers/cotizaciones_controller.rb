class CotizacionesController < ApplicationController

  def administrar

    @clientes = Cliente.all
    @cotizacion = cotizacion_actual
    @prodsCot = @cotizacion.productos

    respond_to do |format|
      format.html
      format.js
      format.json
    end

  end

  def id_u
    self.usuario_id
  end

  def selCliente
    @cliente = Cliente.find_by_rut(params[:rutCliente])

    respond_to do |format|
        format.html {redirect_to '/home'}
        format.js
        format.json {render json: @cliente}
    end
  end

  def buscarProd

    @cotizacion = cotizacion_actual
    if @cotizacion != nil
      @prodsCot = @cotizacion.productos
    end


    if @prodsCot == nil
      @productos = Producto.where("cast(codigo as text) LIKE ? AND descripcion LIKE ? ", "%#{params[:codigo]}%", "%#{params[:desc]}%")
    else
      @productos = Producto.where.not(codigo:@prodsCot.map(&:codigo)).where("cast(codigo as text) LIKE ? AND descripcion LIKE ? ", "%#{params[:codigo]}%", "%#{params[:desc]}%")
    end
      #puts @productos

    respond_to do |format|
      format.html {redirect_to '/home'}
      format.js
      format.json { render json: @productos }
    end
  end

  def agregarProd

    @cotizacion = cotizacion_actual

    @producto = Producto.find_by_codigo(params[:codProd])

    @cotProd = @cotizacion.producto_cotizacions.create(producto:@producto,cantidad:0)

    @prodsCot = @cotizacion.productos

    @productos = Producto.where.not(codigo:@prodsCot.map(&:codigo))

    respond_to do |format|
      format.html {redirect_to '/home'}
      format.js
      format.json { render json: @prodsCot; @cotizacion}
    end
  end

  def cambiarCantidad

    @cotizacion = cotizacion_actual
    @prodsCot = @cotizacion.productos
    @cotProd = @cotizacion.producto_cotizacions.find_by(:producto_id => params[:id_p])
    @cotProd.update(cantidad:params[:cant])

    respond_to do |format|
      format.html {redirect_to '/home'}
      format.js
      format.json { render json: @prodsCot; @cotizacion}
    end
  end

  def cotProd_params
    params.require(:producto_cotizacion).permit(:cantidad)
  end

  def actualizar
    @cotizacion = cotizacion_actual
    @cotizacion.usuario_id = current_user.id
    @cotizacion.cliente_id = params[:cliente_id]
    @cotizacion.fecha = params[:fecha]
    @cotizacion.descuentos = params[:descuentos]
    @cotizacion.estado = params[:estado]
    @cotizacion.forma_de_pago = params[:forma_de_pago]
    @cotizacion.iva = params[:iva]
    @cotizacion.validez = params[:validez]
    @cotizacion.observacion = params[:observacion]
    @cotizacion.total = params[:total]
    @cotizacion.total_neto = params[:total_neto]
    @cotizacion.subtotal = params[:subtotal]
    @cotizacion.save()

    #@cotizacion.save
    session[:estado] = "guardada"
    session[:cot_id] = nil
  end

  def estadisticas
    ano = Time.now.strftime("%Y")
    mes = Time.now.strftime("%m")
    if(params[:ano] != nil)
      @cots = Cotizacion.where("estado IS NOT NULL AND extract(year from fecha) = ? AND extract(month from fecha) = ?",params[:ano],params[:mes])
    else
      @cots = Cotizacion.where("estado IS NOT NULL AND extract(year from fecha) = ? AND extract(month from fecha) = ?",ano,mes)
    end
    
    respond_to do |format|
      format.html 
      format.js
      format.json { render json: @cots}
    end

  end


  def salir

    if session[:estado] = "guardada"
      session[:cot_id] = nil

    end

    #if session[:estado] == "nueva"
    #  Cotizacion.find(session[:cot_id]).destroy
    #end
    #session[:cot_id] = nil

    redirect_to '/home'
  end

  def buscar
    @cotizaciones = Cotizacion.all
    @prodsCot = ProductoCotizacion.all

    #Actualizar estado de cotizaciones



  end

  #def cotizacion_params
  #  params.require(:cotizacion).permit(:estado,:fecha,:forma_de_pago,:cliente_id,:usuario_id,:total_neto,:descuentos,:subtotal,:iva,:total,:informacion,:informe_pago,:validez)
  #end

end
