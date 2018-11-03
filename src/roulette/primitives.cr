require "colorize"
#
# > RED
# 1  3  5  7  9 12 14 16 18 19 21 23 25 27 30 32 34 36
#
# > BLACK
# 2  4  6  8 10 11 13 15 17 20 22 24 26 28 29 31 33 35
#
struct Int32
  def red?
    [
      1, 3, 5, 7, 9, 12, 14,
      16, 18, 19, 21, 23, 25,
      27, 30, 32, 34, 36
    ].includes?(self)
  end

  def black?
    [
      2, 4, 6, 8, 10, 11, 13,
      15, 17, 20, 22, 24, 26,
      28, 29, 31, 33, 35
    ].includes?(self)
  end

  def c : String
    back = if self.red?
             :red
           elsif self.black?
             :black
           else
             :light_green
           end

    s = self.to_s
    s = " " + s if s.size == 1
    s.colorize.fore(:white).back(back).to_s
  end

  def c_half : String
    back = if self.red?
             :red
           elsif self.black?
             :black
           else
             :light_green
           end

    s = self.to_s
    s = s[1] if s.size > 1
    s.colorize.fore(:white).back(back).to_s
  end
end
