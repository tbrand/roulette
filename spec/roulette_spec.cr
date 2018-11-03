require "./spec_helper"

#
# TODO: competetion to be binary
# TODO: @balanceの初期値を変更できるように
#

macro algorithm_works(a)
  it "integration test: {{ a.id }}" do
    a = {{ a.id }}.new
    a.deposit(10000)

    runner = Runner.new(a)
    runner.exec(1000).should be_truthy
  end
end

describe Algorithm do
  algorithm_works(AllRed)
  algorithm_works(Martingale)
  algorithm_works(Pare)
  algorithm_works(TenPercent)
  algorithm_works(DAlembert)
  algorithm_works(AntiDAlembert)
  algorithm_works(Cocomo)
  algorithm_works(MonteCarlo)
end
