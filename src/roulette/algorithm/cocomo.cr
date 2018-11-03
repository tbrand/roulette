class Cocomo < Algorithm
  def bets(prev_spin : Int32) : Array(Bet)
    [Bet.new(BetColor.new(random_color), bet_amount(prev_spin))]
  end

  def bet_amount(prev_spin : Int32) : Int32
    return 1 if bet_history.size <= 2

    if !win?(prev_spin) && !win?(prev_spin-1)
      return amount(prev_spin) + amount(prev_spin-1)
    else
      1
    end
  end
end
