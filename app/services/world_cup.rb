require 'faraday'
require 'json'
require 'net/http'

module WorldCup
  def self.matches
    JSON.parse((Faraday.get 'https://worldcup.sfg.io/matches').body)
        .map { |e| WorldCup::Match.new(e) }
  end

  def self.matches_on(date)
    matches.select { |e| e.starts_at.to_date == date.to_date }
  end
end
