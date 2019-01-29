class Booking < ApplicationRecord
  belongs_to :flight
  belongs_to :user

  validates :seat_price, numericality: { greater_than: 0 }, presence: true
  validates :no_of_seats, numericality: { greater_than: 0 }, presence: true
  validate :flys_in_future

  def flys_in_future
    return if !flight.nil? &&
              !flight.flys_at.nil? &&
              (Time.zone.now <= flight.flys_at)
    errors.add(:flight, "flights can't happen in the past")
  end
end
