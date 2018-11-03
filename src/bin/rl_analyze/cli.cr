require "../runner"
require "../printer"
require "../options"

class Cli
  @deposit   : Int32 = 0
  @spins     : Int32 = 0
  @algorithm : Algorithm.class = Algorithm::ALL[0]

  def parse!
    parser = OptionParser.parse! do |parser|
      banner(parser, "Analyzing Mode")
      option_deposit(parser)
      option_spins(parser)
      option_algorithm(parser)
      option_help(parser)
    end

    if @deposit == 0 || @spins == 0
      puts "Please specify both of '-d' and '-s'"
      puts parser.to_s
      exit -1
    end
  end

  def run
    a = @algorithm.new
    a.deposit(@deposit)

    runner = Runner.new(a)
    result = runner.exec(@spins)
    printer = Printer.new(result)
    printer.show
  end

  include Options
end
