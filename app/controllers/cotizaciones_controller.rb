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
    puts params[:descuento]
    puts params[:Total]
    #@cotizacion.save
    session[:estado] = "guardada"
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


end