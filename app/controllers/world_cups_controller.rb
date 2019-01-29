class WorldCupsController < ApplicationController
  def new
    render json: matches
  end

  def matches
    if params[:date].nil?
      WorldCup.matches
    else
      WorldCup.matches_on(params[:date])
    end
  end
end
