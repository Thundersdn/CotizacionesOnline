class Usuario < ActiveRecord::Base
  has_secure_password

  validates :password, presence:true, length: {minimum: 8}
  validates :rut, presence:true, uniqueness:true


end
