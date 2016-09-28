# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

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

@actualizarGrafico = (ano,mes,modo)->
  console.log("Actualizando grafico")
  console.log("Año: "+ano.value)
  console.log("Mes: "+mes.value)
  console.log("Modo: "+modo.value)
  $.ajax '/cotizaciones/estadisticas',
    type: 'get',
    dataType: 'script',
    data:
      ano: ano.value
      mes: mes.value
      modo: modo.value
@verificarDesc = (desc) ->
  console.log("Verificando descuento")

  if(document.getElementById('Pesos').checked)
    tipo = 1
    console.log("Descuento en pesos")
    total = document.getElementById('total_neto').value
    console.log(total - desc.value)
    if(desc.value < 0)
      desc.value = 0
    if(total - desc.value < 0)
      desc.value = total
    document.getElementById('desc').value = desc.value

  else
    tipo = 2
    console.log("Descuento en porcentaje")
    total = document.getElementById('total_neto').value
    if(desc.value > 100)
      desc.value = 100
    if(desc.value < 0)
      desc.value = 0
    console.log("Descuento del %"+desc.value)
    document.getElementById('desc').value = (total*(desc.value/100))

@actDesc = ()->
  console.log("Descuento aceptado")
  document.getElementById('valorDes').value = 0
  document.getElementById('descuentos').value = document.getElementById('desc').value
  document.getElementById('desc').value = 0
  document.getElementById('subtotal').value = document.getElementById('total_neto').value-document.getElementById('descuentos').value
  sub = document.getElementById('subtotal').value
  document.getElementById('iva').value = Math.trunc(sub*0.19)
  iva = document.getElementById('iva').value
  document.getElementById('total').value = +sub + +iva