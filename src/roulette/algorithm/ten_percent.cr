class TenPercent < Algorithm
  def bets(prev_spin : Int32) : Array(Bet)
    [Bet.new(BetColor.new(random_color), bet_amount(prev_spin))]
  end

  def color(prev_spin : Int32) : BetColor::Color
    prev_spin % 2 == 0 ? BetColor::Color::Red : BetColor::Color::Black
  end

  def bet_amount(prev_spin : Int32) : Int32
    amount = (balance * 0.1).to_i
    return amount if amount > 0
    return balance if balance > 0
    0
  end
end
