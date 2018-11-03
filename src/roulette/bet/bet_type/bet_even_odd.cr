#
# Bet on whether the winning number will be odd or even
#
class BetEvenOdd < BetType
  enum EvenOdd
    Even
    Odd
  end

  def initialize(@even_odd : EvenOdd)
  end

  def win?(number : Int32) : Bool
    case @even_odd
    when EvenOdd::Even
      return number.even?
    when EvenOdd::Odd
      return number.odd?
    end

    raise "unreachable code"
  end

  def dividend : Int32
    2
  end

  def display : String
    case @even_odd
    when EvenOdd::Even
      return "EvenOdd: EVEN"
    when EvenOdd::Odd
      return "EvenOdd: ODD"
    end

    raise "unreachable code"
  end
end
