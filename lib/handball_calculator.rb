module HandballCalculator
  G_INITIAL_RATING_POINTS = 50
  G_GOAL_MADE = 5
  G_GOAL_RECEIVED = -2
  F_INITIAL_RATING_POINTS = 20
  F_GOAL_MADE = 1
  F_GOAL_RECEIVED = -1

  def self.calculate(player_stats)
    player_stats[5].to_i * "HandballCalculator::#{player_stats[4]}_GOAL_MADE".constantize + player_stats[6].to_i * "HandballCalculator::#{player_stats[4]}_GOAL_RECEIVED".constantize + "HandballCalculator::#{player_stats[4]}_INITIAL_RATING_POINTS".constantize
  end
end
