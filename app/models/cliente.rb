class Cliente < ActiveRecord::Base
  self.primary_key = 'rut'
  validates :rut, presence:{:message => "no puede estar vacio"}, uniqueness:{:message => " ya existe en la base de datos"}, rut:{:message => " no es valido"}
  validates :email, email:{:message => "invalido"}

end
