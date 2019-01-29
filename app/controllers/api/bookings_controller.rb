module Api
  class BookingsController < ApplicationController
    # GET /bookings
    def index
      render json: Booking.all
    end

    # GET /bookings/:id
    def show
      booking = Booking.find(params[:id])

      render json: booking
    end

    # POST /bookings
    def create
      booking = Booking.new(booking_params)
      if booking.save
        render json: booking, status: :created
      else
        render json: { errors: booking.errors }, status: :bad_request
      end
    end

    # DELETE /bookings/:id
    def destroy
      booking = Booking.find(params[:id])
      booking.destroy
      head :no_content
    end

    # PATCH/bookings/:id
    def update
      booking = Booking.find(params[:id])
      if booking.update(booking_params)
        render json: booking, status: :ok
      else
        render json: { errors: booking.errors }, status: :bad_request
      end
    end

    private

    def booking_params
      params.require(:booking).permit(:seat_price,
                                      :no_of_seats,
                                      :flight_id,
                                      :user_id)
    end
  end
end
