#
# Bet on the colour of the winning number
#
class BetColor < BetType
  enum Color
    Red
    Black
  end

  def initialize(@color : Color)
  end

  def win?(number : Int32) : Bool
    case @color
    when Color::Red
      return number.red?
    when Color::Black
      return number.black?
    end

    raise "unreachable code"
  end

  def dividend : Int32
    2
  end

  def display : String
    case @color
    when Color::Red
      return "Color: #{"RED".colorize.fore(:red)}"
    when Color::Black
      return "Color: #{"BLACK".colorize.fore(:black)}"
    end

    raise "unreachable code"
  end
end
