json.array!(@usuarios) do |usuario|
  json.extract! usuario, :id, :rut, :nombre, :password, :privilegios, :ultimo_login
  json.url usuario_url(usuario, format: :json)
end
