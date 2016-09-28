class Usuario < ActiveRecord::Base

  has_secure_password

  validates :password, length: {minimum: 8}
  validates :rut, presence:true, uniqueness:{:message => "ya existe en base de datos"}, rut:{:message => "no es valido"}


end
