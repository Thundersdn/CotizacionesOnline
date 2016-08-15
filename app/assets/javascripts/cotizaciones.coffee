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


    


  
