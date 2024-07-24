class Car < ApplicationRecord
  has_many :trips, dependent: :destroy

  validates :brand, presence: true
  validates :model, presence: true
  validates :model, presence: true
end
