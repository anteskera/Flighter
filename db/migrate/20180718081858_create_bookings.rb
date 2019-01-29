class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.integer   :seat_price
      t.integer   :no_of_seats

      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :flight, index: true, foreign_key: true
    end
  end
end
