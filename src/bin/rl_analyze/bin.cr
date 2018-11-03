require "./cli"

cli = Cli.new
cli.parse!
cli.run
