class AllRed < Algorithm
  def bets(prev_spin : Int32) : Array(Bet)
    [Bet.new(BetColor.new(BetColor::Color::Red), 1)]
  end
end
