class Car < ApplicationRecord
  has_many :trips

  validates :brand, presence: true
  validates :model, presence: true
  validates :model, presence: true
end
