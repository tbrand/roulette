require "../runner"

alias Profile = NamedTuple(
        name: String,
        win_count: Int32,
        loose_count: Int32,
        game_over_count: Int32,
        max_win: Int32,
        win_rate: Float64,
        expected: Float64,
      )

def profile(
     algorithm : Algorithm.class,
     deposit   : Int32,
     games     : Int32,
     spins     : Int32
   ) : Profile
  win_count = 0
  max_win = 0
  loose_count = 0
  game_over_count = 0
  total_amount = 0

  games.times do
    a = algorithm.new
    a.deposit(deposit)

    runner = Runner.new(a)
    result = runner.exec(spins)
    total_amount += result[:algorithm].win_amount

    if result[:algorithm].win?
      max_win = result[:algorithm].win_amount if result[:algorithm].win_amount > max_win
      win_count += 1
    else
      loose_count += 1
      game_over_count += 1 if result[:game_over]
    end
  end

  win_rate = (win_count.to_f / (win_count + loose_count).to_f).round(4)
  expected = (total_amount.to_f * win_rate).round(2)

  {
    name: algorithm.name,
    win_count: win_count,
    loose_count: loose_count,
    game_over_count: game_over_count,
    max_win: max_win,
    win_rate: win_rate,
    expected: expected,
  }
end
