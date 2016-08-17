class Cliente < ActiveRecord::Base
  self.primary_key = 'rut'
  validates :rut, presence: true, uniqueness: true

end
