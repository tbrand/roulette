require "../options"
require "./profile"

class Cli
  @title   : String = "No Name"
  @deposit : Int32 = 0
  @games   : Int32 = 0
  @spins   : Int32 = 0

  def parse!
    parser = OptionParser.parse! do |parser|
      banner(parser, "Comparing Mode")
      option_deposit(parser)
      option_games(parser)
      option_spins(parser)
      option_title(parser)
      option_help(parser)
    end

    if @deposit == 0 || @games == 0 || @spins == 0
      puts "Please specify both of '-d', '-g' and '-s'"
      puts parser.to_s
      exit -1
    end
  end

  def run
    puts "### #{@title}"
    puts ""
    puts "- sorted by winning rate"
    puts "- deposit : #{@deposit}"
    puts "- spins   : #{@spins}"
    puts ""
    puts "| Algorithm | Wining Rate | # of Win | # of Loose | Expected |"
    puts "| :-------- | :---------- | :------- | :--------- | :------- |"

    ps = Algorithm::ALL.map do |a|
      profile(a, @deposit, @games, @spins)
    end

    ps.sort_by { |p| -p[:win_rate] }.each do |p|
      name = "%-20s" % [p[:name]]
      rate = ("win rate: %3.2f" % [p[:win_rate] * 100]) + " %"
      win = "win: %8d (max win: %8d)" % [p[:win_count], p[:max_win]]
      loose = "loose: %8d (game over: %8d)" % [p[:loose_count], p[:game_over_count]]
      expected = "expected: %8.2f" % [p[:expected]]

      puts "| #{name} | #{rate} | #{win} | #{loose} | #{expected} |"
    end
  end

  include Options
end
