require "./bet/*"

class Bet
  getter amount   : Int32
  getter result   : Int32 = 0
  getter bet_type : BetType

  def initialize(@bet_type : BetType, @amount : Int32)
  end

  def set_result(number : Int32) : Int32
    @result = @amount * @bet_type.dividend if @bet_type.win?(number)
    @result
  end

  def win? : Bool
    win > 0
  end

  def win : Int32
    @result - @amount
  end
end
