#
# Bet on whether the winning number will be low (lower than 19) or high
#
class BetHighLow < BetType
  enum HighLow
    High
    Low
  end

  def initialize(@high_low : HighLow)
  end

  def win?(number : Int32) : Bool
    case @high_low
    when HighLow::High
      return number >= 19
    when HighLow::Low
      return number <= 18
    end

    raise "unreachable code"
  end

  def dividend : Int32
    2
  end

  def display : String
    case @high_low
    when HighLow::High
      return "HighLow: HIGH"
    when HighLow::Low
      return "HighLow: LOW"
    end

    raise "unreachable code"
  end
end
