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
      #flash[:notice] = "Autenticado"
      redirect_to '/home'
    else
      #si no logra entrar enviarlo de vuela
      flash[:notice] = "Rut o contraseña invalido(s)"
      flash[:color] = "invalid"
      redirect_to '/login'
    end



  end

  def destruir
    session[:id] = nil
    redirect_to '/login'
  end

  def home
  end

  def profile
  end

  def setting
  end
end
