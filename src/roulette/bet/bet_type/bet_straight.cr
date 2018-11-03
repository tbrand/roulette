#
# This is a bet that covers only one number.
# In order to make this bet, place the chip inside the square of the number.
#
class BetStraight < BetType
  def initialize(@number : Int32)
  end

  def win?(number : Int32) : Bool
    @number == number
  end

  def dividend : Int32
    36
  end

  def display : String
    "Number: #{@number.c}"
  end
end
