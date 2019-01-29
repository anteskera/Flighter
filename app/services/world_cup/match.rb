module WorldCup
  class Match
    attr_accessor :venue, :status, :starts_at, :home_team,
                  :away_team, :home_team_events, :away_team_events

    def initialize(input_hash)
      self.venue = input_hash['venue']
      self.status = input_hash['status']
      self.home_team = input_hash['home_team']
      self.starts_at = Time.parse(input_hash['datetime']).utc
      self.away_team = input_hash['away_team']
      self.home_team_events = input_hash['home_team_events']
      self.away_team_events = input_hash['away_team_events']
    end

    def as_json(_opts)
      goals_var = goals_for_json
      score_var = score_for_json
      { away_team: away_team_name, goals: goals_var,
        home_team: home_team_name, score: score_var,
        venue:  venue }
    end

    def goals_for_json
      return '--' if status == 'future'
      home_team_goals + away_team_goals
    end

    def score_for_json
      return '--' if status == 'future'
      "#{home_team_goals} : #{away_team_goals}"
    end

    def home_team_goals
      home_team['goals'] || 0
    end

    def home_team_name
      home_team['country']
    end

    def home_team_code
      home_team['code']
    end

    def away_team_goals
      away_team['goals'] || 0
    end

    def away_team_name
      away_team['country']
    end

    def away_team_code
      away_team['code']
    end

    def events
      home_team_events.map { |e| WorldCup::Event.new(e) }
                      .push(*away_team_events
                        .map { |e| WorldCup::Event.new(e) })
    end

    def goals
      events.select { |e| e.type[/.*goal.*/] }
    end
  end
end
