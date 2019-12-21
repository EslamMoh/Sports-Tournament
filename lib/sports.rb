module Sports
  SPORTS_NAMES = %w[BASKETBALL HANDBALL].freeze
  BASKETBALL_ELEMENTS = 8
  HANDBALL_ELEMENTS = 7

  def self.calculate(results)
    match_players_scores = Hash.new { |h, k| h[k] = 0 } # score of each player
    results.each do |match_result|
      teams_score = Hash.new { |h, k| h[k] = 0 } # scores for each team
      team_players = Hash.new { |h, k| h[k] = [] } # players of each team
      match_result.drop(1).each do |player|
        player_stats = player.split(";")
        match_players_scores[player_stats[1]] += "#{match_result.first.downcase.camelize}Calculator".constantize.calculate(player_stats)
        teams_score[player_stats[3]] += player_stats[5].to_i
        team_players[player_stats[3]].push(player_stats[3])
      end
      # match_players_scores = score for all players per match

      # retrieves the winner team
      winner_team = teams_score.max_by { |k, v| v }.first
      # update the score for winner team players
      team_players[winner_team].each { |player| match_players_scores[player] += 10 }
    end

    match_players_scores.max_by { |k, v| v }.first
  end
end