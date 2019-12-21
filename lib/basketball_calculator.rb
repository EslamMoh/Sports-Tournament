module BasketballCalculator
  G_SCOREPOINT = 2
  G_REBOUND = 3
  G_ASSIST = 1
  F_SCOREPOINT = 2
  F_REBOUND = 2
  F_ASSIST = 2
  C_SCOREPOINT = 2
  C_REBOUND = 1
  C_ASSIST = 3

  def self.calculate(player_stats)
    player_stats[5].to_i * "BasketballCalculator::#{player_stats[4]}_SCOREPOINT".constantize + player_stats[6].to_i * "BasketballCalculator::#{player_stats[4]}_REBOUND".constantize + player_stats[7].to_i * "BasketballCalculator::#{player_stats[4]}_ASSIST".constantize
  end
end
