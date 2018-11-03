class MonteCarlo < Algorithm
  @array : Array(Int32) = [1, 2, 3]

  def bets(prev_spin : Int32) : Array(Bet)
    [Bet.new(BetColor.new(random_color), bet_amount(prev_spin))]
  end

  def bet_amount(prev_spin : Int32) : Int32
    return @array.first + @array.last if prev_spin == 0

    if win?(prev_spin)
      if @array.size >= 4
        @array.shift
        @array.pop
      else
        @array = [1, 2, 3]
      end
    else
      @array.push(@array.first + @array.last)
    end

    return @array.first + @array.last
  end
end
