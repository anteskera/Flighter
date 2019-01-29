class BookingSerializer < ActiveModel::Serializer
  attributes :id, :seat_price, :no_of_seats

  belongs_to :flight
  belongs_to :user
end
