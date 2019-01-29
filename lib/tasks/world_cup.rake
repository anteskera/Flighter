namespace :world_cup do
  desc 'displays score'
  task :scores, [:date] => [:environment] do |_task, args|
    temp = WorldCup.matches_on args[:date]
    tp temp,
       [
         { VENUE: { display_method: :venue } },
         { HOME_TEAM: { display_method: :home_team_name } },
         { AWAY_TEAM: { display_method: :away_team_name } },
         {
           SCORE: {
             display_method:
               lambda { |match|
                 "#{match.home_team_goals} : #{match.away_team_goals}"
               }
           }
         }
       ]
  end
end
