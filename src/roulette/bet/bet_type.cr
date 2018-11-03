abstract class BetType
  abstract def win?(number : Int32) : Bool
  abstract def dividend : Int32
  abstract def display : String
end

require "./bet_type/*"
