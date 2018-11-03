require "../roulette"

class Runner
  alias Result = NamedTuple(roulette: Roulette, algorithm: Algorithm, game_over: GameOver?)

  @r : Roulette

  def initialize(@a : Algorithm)
    @r = Roulette.new
  end

  def exec(spins : Int32 = 1000, n : Int32? = nil) : Result
    spins.times do |_|
      @r.spin(@a, n)
    end

    return {
      roulette: @r,
      algorithm: @a,
      game_over: nil,
    }
  rescue e : GameOver
    return {
      roulette: @r,
      algorithm: @a,
      game_over: e,
    }
  end
end
