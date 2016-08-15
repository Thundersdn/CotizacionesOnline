class Cliente < ActiveRecord::Base
  validates :rut, presence: true, uniqueness: true

end
