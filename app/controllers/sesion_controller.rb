class SesionController < ApplicationController

  #before_filter :autenticar_usuario, :only => [:home, :profile, :setting]
  #before_filter :guardar_estado_login, :only => [:login, :intento_login]

  def login
  end

  def crear

    usuario = Usuario.find_by_rut(params[:rut])

    #Si el usuario existe y la contraseña es la correcta
    if usuario && usuario.authenticate(params[:pass])
      #guardar la id en una cookie
      session[:id] = usuario.id
      usuario.update_attribute(:ultimo_login, Time.now)
      #flash[:notice] = "Autenticado"
      session[:cot_id] = nil
      redirect_to '/home'
    else
      #si no logra entrar enviarlo de vuela
      flash[:notice] = "Rut o contraseña invalido(s)"
      flash[:color] = "invalid"
      redirect_to '/login'
    end



  end

  def destruir
    #session[:id] = nil
    #if session[:cot_id] != nil && session[:estado] == "nueva"
    #  Cotizacion.find(session[:cot_id]).destroy
    #  session[:cot_id] = nil
    #end

    redirect_to '/login'
  end

  def home
  end

  def profile
  end

  def setting
  end
end
