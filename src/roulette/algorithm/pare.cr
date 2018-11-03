class Pare < Algorithm
  def bets(prev_spin : Int32) : Array(Bet)
    [Bet.new(BetColor.new(random_color), bet_amount(prev_spin))]
  end

  def bet_amount(prev_spin : Int32) : Int32
    return 1 if prev_spin == 0

    if amount(prev_spin) >= 16 || !win?(prev_spin)
      return 1
    else
      return amount(prev_spin) * 2
    end
  end
end
