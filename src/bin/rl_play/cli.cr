require "../runner"
require "../options"

class Input < Algorithm
  def bets(prev_spin : Int32) : Array(Bet)
    if input = gets
      bet_type, amount = input.split(" ")
      amount = amount.to_i

      case bet_type
      when "red"
        [Bet.new(BetColor.new(BetColor::Color::Red), amount)]
      when "black"
        [Bet.new(BetColor.new(BetColor::Color::Black), amount)]
      else
        puts "Unknown bet type \"#{bet_type}\""
        print "> "
        bets(prev_spin)
      end
    else
      puts "Not input"
      print "> "
      bets(prev_spin)
    end
  rescue e : Exception
    puts "Invalid input format"
    print "> "
    bets(prev_spin)
  end
end

class RoulatteAnimation
  NUMS = [
    0, 32, 15, 19, 4, 21,
    2, 25, 17, 34, 6, 27,
    13, 36, 11, 30, 8, 23,
    10, 5, 24, 16, 33, 1,
    20, 14, 31, 9, 22, 18,
    29, 7, 28, 12, 35, 3, 26,
  ]
  NUMS_WIDE = NUMS + NUMS

  def self.run(n : Int32)
    puts " " * 15 + "\\/"

    start = (index(n) + 23) % 37

    10.times do |i|
      3.times do |step|
        show(shown(start + i), step) if i != 9 || step != 2
        sleep 0.002 * i * i
      end
    end

    puts
  end

  def self.index(n : Int32)
    NUMS_WIDE.each_with_index do |_n, i|
      return i if _n == n
    end

    raise "Unexpected number: #{n}"
  end

  def self.shown(start : Int32, range : Int32 = 10)
    NUMS_WIDE[start..start+range]
  end

  def self.show(nums : Array(Int32), step : Int32 = 0)
    line = case step
           when 0
             " " + nums[0..nums.size-2].map { |n| n.c }.join(" ") + " " + nums.last.c_half
           when 1
             nums.map { |n| n.c }.join(" ")
           when 2
             nums.first.c_half + " " + nums[1..nums.size-1].map { |n| n.c }.join(" ")
           end

    print "\e[G"
    print "\e[K"
    print line
  end
end

class Cli
  @deposit   : Int32 = 0

  def parse!
    parser = OptionParser.parse! do |parser|
      banner(parser, "Playing Mode")
      option_deposit(parser)
    end

    if @deposit == 0
      puts "Please specify '-d'"
      puts parser.to_s
      exit -1
    end
  end

  def run
    a = Input.new
    a.deposit(@deposit)

    runner = Runner.new(a)

    red = "red".colorize.back(:red).fore(:white)
    black = "black".colorize.back(:black).fore(:white)

    puts
    puts red_black "                                                                  ", true
    puts red_black "                           PLAYING MODE                           "
    puts red_black "                                                                  ", true
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Rule ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~".colorize.back(:white).fore(:black).mode(:bold)
    puts "  - Currently only 'red' and 'black' are supported as bet types.  ".colorize.back(:white).fore(:black).mode(:bold)
    puts "  - Input following format for your bets.                         ".colorize.back(:white).fore(:black).mode(:bold)
    puts "                                                                  ".colorize.back(:white).fore(:black).mode(:bold)
    puts "  > [byte_type] [amount]                                          ".colorize.back(:white).fore(:black).mode(:bold)
    puts "  > red 100 (Example)                                             ".colorize.back(:white).fore(:black).mode(:bold)
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~".colorize.back(:white).fore(:black).mode(:bold)
    puts

    100.times do |i|
      spin = "##{i}".colorize.fore(:yellow).mode(:bold)
      puts  "> Next Spin! #{spin}"
      print "> "

      r = runner.exec(1)

      game_over(r[:game_over].to_s) if r[:game_over]

      n = r[:roulette].history.last

      RoulatteAnimation.run(n)

      puts
      puts "> The number is #{n.c}!"
      puts "> Now you have #{r[:algorithm].balance.colorize.fore(:cyan).mode(:bold)}$"

      game_over("Reason: you don't have balance anymore") if r[:algorithm].balance == 0
    end
  end

  def red_black(text : String, rev : Bool = false)
    text.chars.map_with_index { |c, i| c.colorize.back((i/2)%2==(rev ? 0 : 1) ? :red : :black).fore(:white) }.join("")
  end

  def game_over(reason : String)
    puts
    puts "> " + "GAME OVER!!!".colorize.fore(:red).mode(:bold).to_s
    puts "> " + "#{reason}".colorize.fore(:red).mode(:bold).to_s
    puts
    exit -1
  end

  include Options
end
