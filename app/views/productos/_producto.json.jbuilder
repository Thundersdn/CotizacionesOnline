json.extract! producto, :id, :codigo, :descripcion, :valor_unitario, :descuento,  :stock, :estado, :created_at, :updated_at
json.url producto_url(producto, format: :json)