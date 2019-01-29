class FlightSerializer < ActiveModel::Serializer
  attributes :name, :flys_at, :lands_at, :base_price, :id, :no_of_seats

  has_many :bookings
  belongs_to :company
end
