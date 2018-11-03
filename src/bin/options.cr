require "option_parser"

module Options
  def banner(parser : OptionParser, name : String)
    parser.banner = "\n  #{name.colorize.fore(:yellow).mode(:bold)}\n"
  end

  def option_deposit(parser : OptionParser)
    parser.on(
      "-d DEPOSIT",
      "--deposit=DEPOSIT",
      "First deposit amount (required)"
    ) do |deposit|
      @deposit = deposit.to_i
    end
  end

  def option_games(parser : OptionParser)
    parser.on(
      "-g GAMES",
      "--games=GAMES",
      "Number of games (required)"
    ) do |games|
      @games = games.to_i
    end
  end

  def option_spins(parser : OptionParser)
    parser.on(
      "-s SPINS",
      "--spins=SPINS",
      "Number of spins (Default is #{@spins})"
    ) do |spins|
      @spins = spins.to_i
    end
  end

  def option_help(parser : OptionParser)
    parser.on("-h", "--help", "Show this help") do
      puts parser.to_s
      exit 0
    end
  end

  def option_algorithm(parser : OptionParser)
    parser.on(
      "-a ALGORITHM",
      "--algorithm=ALGORITHM",
      "Select an algorithm (It's one of #{algorithm_names}. Default is #{@algorithm.name})"
    ) do |algorithm|
      a = Algorithm::ALL.select { |a| a.name == algorithm }

      if a.size == 0
        puts "Invalid algorithm: \"#{algorithm}\". It's one of #{algorithm_names}"
        puts parser.to_s
        exit 0
      end

      @algorithm = a.first
    end
  end

  def algorithm_names : Array(String)
    Algorithm::ALL.map { |a| a.name }
  end

  def option_title(parser : OptionParser)
    parser.on(
      "-t TITLE",
      "--title=TITLE",
      "Set title of the competition (Default is #{@title})"
    ) do |title|
      @title = title
    end
  end
end
