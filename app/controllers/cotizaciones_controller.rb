class CotizacionesController < ApplicationController

  def administrar
    @cots = Cotizacion.all
    #Actualizar estado de cotizaciones
    @cots.each do |c|
      if c.fecha == nil && c.validez == nil
        c.destroy
      end
    end

    @clientes = Cliente.all
    if params[:cot_id].present?
      if(Cotizacion.exists?(:id =>params[:cot_id]))
        session[:cot_id]  = params[:cot_id]
        @cot = cotizacion_actual
        @prodsCot = @cot.productos
        @cliente = Cliente.find(@cot.cliente_id)
        session[:estado] = "guardada"
      else
        redirect_to '/home'
        return
      end
    else
      puts "NUEVA COTIZACION"
      @cot = cotizacion_actual
      @prodsCot = nil
      @cliente = nil
      session[:estado] = "nueva"
    end

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
    @cot = cotizacion_actual
    @prodsCot = @cot.productos
    if @prodsCot == nil
      puts "prodsCot es nulo!"
      @productos = Producto.where("cast(codigo as text) LIKE ? AND descripcion LIKE ? ", "%#{params[:codigo]}%", "%#{params[:desc]}%")
    else
      puts @prodsCot
      @productos = Producto.where.not(codigo:@prodsCot.map(&:codigo)).where("cast(codigo as text) LIKE ? AND descripcion LIKE ? ", "%#{params[:codigo]}%", "%#{params[:desc]}%")
    end

    respond_to do |format|
      format.html {redirect_to '/home'}
      format.js
      format.json { render json: @productos }
    end
  end

  def agregarProd
    @cot = cotizacion_actual
    @producto = Producto.find_by_codigo(params[:codProd])
    
    @cotProd = @cot.producto_cotizacions.create(producto:@producto,cantidad:0)
    #@cot.producto_cotizacions.build(producto:@producto,cantidad:0)

    @prodsCot = @cot.productos
    @productos = Producto.where.not(codigo:@prodsCot.map(&:codigo))

    respond_to do |format|
      format.html {redirect_to '/home'}
      format.js
      format.json { render json: @prodsCot; @cot;@productos}
    end
  end

  def cambiarCantidad
    @cot = cotizacion_actual
    @prodsCot = @cot.productos
    @cotProd = @cot.producto_cotizacions.find_by(:producto_id => params[:id_p])
    @cotProd.update(cantidad:params[:cant])

    respond_to do |format|
      format.html {redirect_to '/home'}
      format.js
      format.json { render json: @prodsCot; @cot}
    end
  end

  def cotProd_params
    params.require(:producto_cotizacion).permit(:cantidad)
  end

  def enviarCorreo
    @cot = cotizacion_actual
    Cartero.cotizacionMail(cotizacion_actual).deliver_now

    redirect_to '/home'
  end

  def actualizar
    @cot = cotizacion_actual
    @cot.usuario_id = current_user.id
    @cot.cliente_id = params[:usuario_id]
    @cot.fecha = params[:fecha]
    @cot.descuentos = params[:descuentos]
    @cot.estado = params[:estado]
    @cot.forma_de_pago = params[:forma_de_pago]
    @cot.iva = params[:iva]
    @cot.validez = params[:validez]
    @cot.observacion = params[:observacion]
    @cot.total = params[:total]
    @cot.total_neto = params[:total_neto]
    @cot.subtotal = params[:subtotal]
    @cot.save
    session[:cot_id] = nil
    session[:estado] == "guardada"


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

    #if session[:estado] == "guardada"
    #  session[:cot_id] = nil
    #end

    if session[:estado] == "nueva" && session[:cot_id] != nil
      Cotizacion.find(session[:cot_id]).delete
    end
    session[:cot_id] = nil

    redirect_to '/home'
  end

  def buscar
    @cot = Cotizacion.all
    @prodsCot = ProductoCotizacion.all

    #Actualizar estado de cotizaciones
    @cot.each do |c|6
      if c.fecha && c.validez && c.cliente_id && c.usuario_id
        dif = (Time.zone.now - c.fecha).to_i / 1.day
        if(c.validez < dif)
          c.estado = "Expirada"
          c.validez = 0
        end

      else
        c.delete
      end
    end

    @cot = Cotizacion.all

    num = params[:Num]
    rut = params[:Rut]
    fecha = params[:Fecha]
    estado = params[:Estado]

    if num || rut || fecha || estado
      rut.tr('.','')
      f = fecha.split("/")
      puts "Filtrando"
      if fecha.length >= 8
        @cot = Cotizacion.where("cast(id as text) LIKE ? AND cliente_id LIKE ? and estado = ? and  extract(year from fecha) = ? AND extract(month from fecha) = ? AND extract(day from fecha) = ?","%#{num}%", "%#{rut}%", "#{estado}",f[2],f[1],f[0] )
      else
        @cot = Cotizacion.where("cast(id as text) LIKE ? AND cliente_id LIKE ? and estado = ?","%#{num}%", "%#{rut}%", "#{estado}")
      end
    end
    respond_to do |format|
      format.html 
      format.js
      format.json { render json: @cot}
    end


  end

  def confirmar
  end 

  def imprimir
    puts params[:cot_id]
    if params[:cot_id] != nil && Cotizacion.exists?(params[:cot_id])
      @cot = Cotizacion.find(params[:cot_id])
      @cli = Cliente.find(@cot.cliente_id)
      @usu = Usuario.find(@cot.usuario_id)
      @prodsCot = @cot.productos
      @cot = Cotizacion.find(params[:cot_id])
    else
      redirect_to '/home'
    end
  end

  def eliminarCot
    Cotizacion.find(params[:cot_id]).delete
    redirect_to '/cotizaciones/buscar'

  end

end
