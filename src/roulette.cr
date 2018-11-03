require "./roulette/*"

class Roulette
  getter history : Array(Int32) = [] of Int32

  def initialize
  end

  def spin(a : Algorithm, n : Int32? = nil)
    bets = a.bets(spins)
    spin(a, bets, n)
  end

  def spin(a : Algorithm, bets : Array(Bet), n : Int32? = nil)
    bets_total = bets.reduce(0) { |s, b| s + b.amount }

    if bets_total > a.balance || bets_total == 0
      raise GameOver.new("Bets total: #{bets_total}. But you have only #{a.balance}.")
    end

    @history << (n || random)

    win = bets.reduce(0) { |s, b| s + b.set_result(@history.last) }
    total = win - bets_total

    a.set_result(total, @history.last, bets)    
  end

  def random : Int32
    Random.rand(37)
  end

  def spins : Int32
    @history.size
  end
end
