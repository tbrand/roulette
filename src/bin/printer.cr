class Printer
  def initialize(@result : Runner::Result)
  end

  def show(
       title        : Bool = true,
       status       : Bool = true,
       algorithm    : Bool = true,
       balance      : Bool = true,
       win_num      : Bool = true,
       histories    : Bool = true,
       distribution : Bool = true,
     )
    puts ""
    puts_title if title
    puts_status if status
    puts_algorithm if algorithm
    puts_balance if balance
    puts_win_num if win_num
    puts_histories if histories
    puts_distribution if distribution
    puts ""
  end

  def r : Runner::Result
    @result
  end

  def total_spins : Int32
    r[:roulette].spins
  end

  def is_game_over? : Bool
    !r[:game_over].nil?
  end

  def game_over_reason : String
    r[:game_over].to_s
  end

  def win_amount : Int32
    r[:algorithm].win_amount
  end

  def win_num : Int32
    r[:algorithm]
      .bet_history
      .count { |bets| bets.reduce(0) { |s, b| s + b.win } > 0 }
  end

  def loose_num : Int32
    total_spins - win_num
  end

  def start_balance : Int32
    r[:algorithm].start_balance
  end

  def result_balance : Int32
    r[:algorithm].result_balance
  end

  def algorithm_name : String
    r[:algorithm].name
  end

  def puts_title
    puts "+- RESULT (total spins: #{total_spins.colorize.fore(:yellow)})"
    puts "|"
  end

  def puts_status
    status = if is_game_over?
               "GameOver: #{game_over_reason}".colorize.mode(:bold).fore(:light_gray)
             elsif win_amount > 0
               "Win! (+#{win_amount})".colorize.mode(:bold).fore(:cyan)
             else
               "Loose... (#{win_amount})".colorize.mode(:bold).fore(:red)
             end

    puts "+--+ Status"
    puts "|  +-- #{status}"
    puts "|"
  end

  def puts_algorithm
    puts "+--+ Algorithm"
    puts "|  +-- #{algorithm_name.colorize.mode(:bold).fore(:yellow)}"
    puts "|"
  end

  def puts_balance
    puts "+--+ Total Balance"
    puts "|  +-- #{result_balance} [$] (From #{start_balance} [$])"
    puts "|"
  end

  def puts_win_num
    puts "+--+ Total # of win/loose"
    puts "|  +-- Win: #{win_num.colorize.fore(:cyan)}, Loose: #{loose_num.colorize.fore(:red)}"
    puts "|"
  end

  def puts_histories
    num = [r[:roulette].history.size, 20].min
    nums = r[:roulette].history.reverse.first(num)
    bets = r[:algorithm].bet_history.reverse.first(num)
    balances = r[:algorithm].balance_history.reverse.first(num)
    widths = num.times.to_a.map { |n| [2, balances[n].to_s.size ].max }

    puts  "+--+ Recent #{num} Histories (Left is Newer)"
    print "|  +-- Numbers: "

    num.times do |i|
      spaces = widths[i] - 2 > 0 ? " " * (widths[i] - 2) : ""
      print "#{spaces + nums[i].c} "
    end

    print "\n|  +-- Balance: "

    num.times do |i|
      win = bets[i].reduce(0) { |s, b| s + b.win } > 0
      color = win ? :cyan : :red
      b = balances[i].colorize.fore(color)
      spaces = balances[i].to_s.size <= 1 ? " " : ""
      print "#{spaces}#{b} "
    end

    puts ""
    puts "|"
  end

  def puts_distribution
    puts  "+--+ Distribution"
    print "|  +-- Numbers: "

    widths = 37.times.to_a.map { |n|
      [2, r[:roulette].history.select {|h| h == n }.size.to_s.size ].max}

    37.times.to_a.map do |n|
      spaces = widths[n] - 2 > 0 ? " " * (widths[n] - 2) : ""
      print "#{spaces + n.c} "
    end

    print "\n|  +-- Counts : "

    37.times.to_a.map do |n|
      count = r[:roulette].history.select {|h| h == n }.size
      spaces = count.to_s.size <= 1 ? " " : ""
      print "#{spaces}#{count} "
    end

    puts ""
    puts "|"
  end
end
