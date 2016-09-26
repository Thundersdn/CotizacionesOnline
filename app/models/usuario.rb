class Usuario < ActiveRecord::Base

  has_secure_password


  validates :password, length: {minimum: 8}
  validates :rut, presence:true, uniqueness:true, rut:{:message => "no valido"}


end
