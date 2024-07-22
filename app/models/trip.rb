class Trip < ApplicationRecord
  belongs_to :user
  belongs_to :car

  validates :from, presence: true
  validates :distance, presence: true
  validates :to, presence: true
  validates :date_beginning, presence: true
  validates :date_end, presence: true

  validate :car_not_already_booked
  validate :valid_end_date

  private
  def car_not_already_booked
    overlapping_trips = Trip.where(car_id: car_id)
                            .where.not(id: id)
                            .where('date_beginning <= ? AND date_end >= ?', date_end, date_beginning)
    if overlapping_trips.exists?
      errors.add(:car_id, 'is already booked in this period')
    end
  end

  def valid_end_date
    if date_end < date_beginning
      errors.add(:date_end, 'must comes after or be equal to beginning date')
    end
  end

end
