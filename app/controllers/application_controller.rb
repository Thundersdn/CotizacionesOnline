class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= Usuario.find(session[:id]) if session[:id]
  end
  helper_method :current_user

  def cotizacion_actual
    #@cotizacion_actual ||= Cotizacion.new(:id => Cotizacion.maximum(:id).to_i.next)
    #@cotizacion_actual ||= Cotizacion.find(session[:cot_id]) if session[:cot_id]
    puts "Entrando en cotizacion actual"
    if session[:cot_id] == nil
      puts "Creando cotizacion"
      @cotizacion_actual = Cotizacion.create
      session[:cot_id] = @cotizacion_actual.id
      session[:estado] = "nueva"
      puts "Cotizacion creada! id= " + @cotizacion_actual.id.to_s()
    else
      if Cotizacion.exists?(id: session[:cot_id])
        puts "Recuperando cotizacion"
        @cotizacion_actual = Cotizacion.find(session[:cot_id])
      else
        @cotizacion_actual = Cotizacion.create(id:session[:cot_id])
      end
    end
    return @cotizacion_actual
  end
  helper_method :cotizacion_actual

  def authorize
    #logger.debug "Ejecutando antes de la accion #{self.action_name} del controlador #{self.controller_name}"
    redirect_to '/login' unless current_user
    if self.controller_name == 'usuarios' && current_user.privilegios < 4
      redirect_to '/home'
    end

  end
end
