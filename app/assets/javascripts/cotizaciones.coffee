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

@cambiarCantidad = (e,id,stock)->
  #console.log("Cambiando cantidad: "+e.value)
  #console.log("Stock: "+stock)
  if stock < e.value
    console.log("cantidad es mayor que el stock!")
    e.value = stock
  if e.value < 0
    alert("No puede poner una cantidad negativa!")
    e.value = 0

  $.ajax '/cotizaciones/cambiarCantidad',
    type: 'get',
    dataType: 'script',
    data:
      cant: e.value
      id_p: id

@actualizarGrafico = (ano,mes,modo)->
  #console.log("Actualizando grafico")
  #console.log("Año: "+ano.value)
  #console.log("Mes: "+mes.value)
  #console.log("Modo: "+modo.value)
  $.ajax '/cotizaciones/estadisticas',
    type: 'get',
    dataType: 'script',
    data:
      ano: ano.value
      mes: mes.value
      modo: modo.value
@verificarDesc = (desc) ->
  #console.log("Verificando descuento")

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


@buscarCot = () ->
  Num = $('#NCot').val()
  Fecha = $('#fecha').val()
  Rut = $('#RCli').val()
  Estado = $('#estado').val()
  console.log("Numero: "+Num)
  console.log("Rut: "+Rut)
  console.log("Fecha: "+Fecha)
  console.log("Estado: "+Estado)
  $.ajax '/cotizaciones/buscar',
    type: 'get',
    dataType: 'script',
    data:
      Num: Num
      Rut: Rut
      Fecha: Fecha
      Estado: Estado


@validarCotizacion = () ->
  registrar = true
  mensaje = ""
  UCli = $('#usuario_id').val()
  RUsu = $('#rut').val()
  Mail = $('#email').val()
  Validez = $('#validez').val()
  Estado = $('#estado').val()


  if !@validarRut(UCli)
    $('#usuario_id').css("color","red")
    mensaje += "-Rut de cliente invalido\n"
    registrar = false
  else
    $('#usuario_id').css("color","black")

  if !@validarEmail(Mail)
    $('#email').css("color","red")
    mensaje += "-Email de cliente invalido\n"
    registrar = false
  else
    $('#email').css("color","black")

  if !@validarRut(RUsu)
    $('#rut').css("color","red")
    mensaje += "-Rut de Funcionario invalido\n"
    registrar = false
  else
    $('#rut').css("color","black")

 
  if(cProd == 0)
    mensaje += "-La cotizacion debe contener almenos 1 producto!\n"
    registrar = false

  if(Validez <= 0 && Estado != "Expirada")
    mensaje += "-Debe ingresar cantidad de dias de validez de la cotizacion\n"
    registrar = false


  mensaje += "Porfavor arreglar errores"
  if !registrar
    alert(mensaje)
    
  return registrar
  

@validarEmail = (email) ->
  re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
  re.test email

@formatRut = (str) ->
  str.replace(/\./g, '')

@validarRut = (str) ->
  if not str?
    return false
 
  str = str.toString().trim()
  str = formatRut str
 
  if not str.indexOf('-') is str.length - 2
    return false
 
  chars = new Array()
  serie = new Array(2, 3, 4, 5, 6, 7)
  dig = str.substr(str.length - 1, 1)
  rut = str.substr(0, str.length - 2)
 
  for i in [0..rut.length-1] by 1
    chars[i] = parseInt rut.charAt( (rut.length - 1 - i) )
 
  sum = 0
  k = 0
  resto = 0
 
  for j in [0..chars.length-1] by 1
    k = 0 if k == 6
    sum += parseInt(chars[j]) * parseInt(serie[k]);
    k++
 
  resto = sum % 11;
  dv = 11 - resto;
  dv = "K" if dv == 10
  dv = 0 if dv == 11
 
  return dv.toString().trim().toUpperCase() == dig.toString().trim().toUpperCase()