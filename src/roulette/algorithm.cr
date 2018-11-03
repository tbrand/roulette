abstract class Algorithm
  getter balance : Int32 = 0
  getter balance_history : Array(Int32) = [] of Int32
  getter bet_history : Array(Array(Bet)) = [] of Array(Bet)

  ALL = [
    AllRed,
    Martingale,
    Pare,
    TenPercent,
    DAlembert,
    AntiDAlembert,
    Cocomo,
    MonteCarlo,
  ]

  def deposit(@balance : Int32)
    @balance_history << @balance
    @bet_history << [] of Bet
  end

  def set_result(total : Int32, number : Int32, bets : Array(Bet))
    @balance += total
    @balance_history << @balance
    @bet_history << bets
  end

  def start_balance : Int32
    @balance_history.first
  end

  def result_balance : Int32
    @balance_history.last
  end

  def name : String
    self.class.name
  end

  def win?(prev_spin : Int32) : Bool
    bet_history[prev_spin].reduce(0) { |s, b| s + b.result } > 0
  end

  def amount(prev_spin : Int32) : Int32
    bet_history[prev_spin].reduce(0) { |s, b| s + b.amount }
  end

  def win_amount : Int32
    result_balance - start_balance
  end

  def win? : Bool
    win_amount > 0
  end

  def random_color : BetColor::Color
    [BetColor::Color::Red, BetColor::Color::Black][rand(2)]
  end

  abstract def bets(prev_spin : Int32) : Array(Bet)
end

require "./algorithm/*"
