# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@mostrarClientes = ->
  #console.log("Mostrar Busqueda de Clientes")
  element = document.getElementsByName('buscarCli')[0]
  if element.style.display is "block"
    element.style.display = "none"
  else
    element.style.display = "block"
    
@abrirListaProd = ->
  element = document.getElementsByName('buscarProd')[0]
  if element.style.display is "block"
    element.style.display = "none"
  else
    element.style.display = "block"


@buscarCliente = (rut) ->
  #console.log("Buscando cliente: "+rut)
  lista = $('#listaClientes').children()
  for r, i in lista
    #console.log(r,i)
    rutl = r.children[1].innerHTML

    if rutl.indexOf(rut) != 0
      r.hidden = true
    else
      r.hidden = false


@buscarProd = (cod,des) ->
#console.log(cod.value)
#console.log(des.value)
  $.ajax '/cotizaciones/buscarProd',
    type: 'get',
    dataType: 'script',
    data:
      codigo: cod.value
      desc: des.value

@cambiarCantidad = (e,id)->
  console.log("Cambiando cantidad: "+e.value)

  $.ajax '/cotizaciones/cambiarCantidad',
    type: 'get',
    dataType: 'script',
    data:
      cant: e.value
      id_p: id


    


  
