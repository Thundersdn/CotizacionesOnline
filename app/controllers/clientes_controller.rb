class ClientesController < ApplicationController

  before_action :set_cliente, only: [:show]
  def index
    @clientes = Cliente.all
  end

  def show
  end

  def new
    @cliente = Cliente.new

  end

  def create
    @cliente = Cliente.new(cliente_params)
    respond_to do |format|
      if @cliente.save
        format.html { redirect_to @cliente, notice: 'Cliente agregado satisfactoriamente.' }
        format.json { render :show, status: :created, location: @usuario }
      else
        format.html { render :new }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def set_cliente
    @cliente = Cliente.find(params[:id])
  end
  def cliente_params
    params.require(:cliente).permit(:rut,:nombres,:direccion,:ciudad,:comuna,:telefono,:fax,:email)
  end
end
