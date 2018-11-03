class DAlembert < Algorithm
  def bets(prev_spin : Int32) : Array(Bet)
    [Bet.new(BetColor.new(random_color), bet_amount(prev_spin))]
  end

  def bet_amount(prev_spin : Int32) : Int32
    return 1 if prev_spin == 0
    
    if win?(prev_spin)
      [amount(prev_spin) + 1, balance].min
    else
      [[amount(prev_spin) - 1, 1].max, balance].min
    end
  end
end
