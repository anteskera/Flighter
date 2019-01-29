module Api
  class FlightsController < ApplicationController
    # GET /flights
    def index
      render json: Flight.all
    end

    # GET /flights/:id
    def show
      flight = Flight.find(params[:id])

      render json: flight
    end

    # POST /flights
    def create
      flight = Flight.new(flight_params)
      if flight.save
        render json: flight, status: :created
      else
        render json: { errors: flight.errors }, status: :bad_request
      end
    end

    # DELETE /flights
    def destroy
      flight = Flight.find(params[:id])
      flight.destroy
      head :no_content
    end

    # POST/flights
    def update
      flight = Flight.find(params[:id])
      if flight.update(flight_params)
        render json: flight, status: :ok
      else
        render json: { errors: flight.errors }, status: :bad_request
      end
    end

    private

    def flight_params
      params.require(:flight).permit(:name,
                                     :no_of_seats,
                                     :base_price,
                                     :flys_at,
                                     :lands_at,
                                     :company_id)
    end
  end
end
