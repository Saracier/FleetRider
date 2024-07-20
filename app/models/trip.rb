class Trip < ApplicationRecord
  belongs_to :user
  belongs_to :car

  validates :from, presence: true
  validates :distance, presence: true
  validates :to, presence: true
  validates :date_beginning, presence: true
  validates :date_end, presence: true
end
