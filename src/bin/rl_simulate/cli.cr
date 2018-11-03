require "../options"
require "../runner"

class Cli
  @deposit : Int32 = 0
  @algorithm : Algorithm.class = Algorithm::ALL[0]

  def parse!
    parser = OptionParser.parse! do |parser|
      banner(parser, "Simulation Mode")
      option_deposit(parser)
      option_algorithm(parser)
      option_help(parser)
    end

    if @deposit == 0
      puts "Please specify '-d'"
      puts parser.to_s
      exit -1
    end
  end

  def run
    a = @algorithm.new
    a.deposit(@deposit)

    puts "> Simulated algorithm: #{a.name.colorize.fore(:yellow).mode(:bold)}"

    runner = Runner.new(a)

    spin = 0

    loop do
      bets = a.bets(spin)

      puts
      puts "> Simulated bets are"
      puts
      bets.each_with_index do |b, i|
        puts "#{i+1}. Bet: #{b.bet_type.display}, Amount: #{b.amount}"
      end
      puts

      puts  "> Input nuber"
      print "> "

      if i = gets
        n = i.to_i
        r = runner.exec(1, n)
        b = r[:algorithm].balance

        if b == 0
          puts "> GAME OVER!"
          exit -1
        end
      else
        puts "Not bets"
      end

      puts "> Current balance #{b}"

      spin += 1
    end
  rescue e : GameOver
    puts "> GAME OVER!"
    exit -1
  end

  include Options
end
