require 'benchmark/ips'
require 'fast_blank_java'

class String
  # active support implementation
  def slow_blank?
    /\A[[:space:]]*\z/ === self
  end

  def new_slow_blank?
    empty? || !(/[[:^space:]]/ === self)
  end
end

test_strings = [
  "",
  "\r\n\r\n  ",
  "this is a test",
  "   this is a longer test",
  "   this is a longer test
      this is a longer test
      this is a longer test
      this is a longer test
      this is a longer test"
]

test_strings.each do |s|
  raise "failed on #{s.inspect} blank? => #{s.blank?} : slow_blank? => #{s.slow_blank?}" if s.blank? != s.slow_blank?
  raise "failed on #{s.inspect} blank? => #{s.blank?} : new_slow_blank? => #{s.new_slow_blank?}" if s.blank? != s.new_slow_blank?
end

test_strings.each do |s|
  puts "\n================== Test String Length: #{s.length} =================="
  Benchmark.ips do |x|
    x.report("Fast Blank Java") do |times|
      i = 0
      while i < times
        s.blank?
        i += 1
      end
    end

    x.report("Fast Blank Java AS") do |times|
      i = 0
      while i < times
        s.fast_blank_java_as?
        i += 1
      end
    end

    x.report("Slow Blank") do |times|
      i = 0
      while i < times
        s.slow_blank?
        i += 1
      end
    end

    x.report("New Slow Blank") do |times|
      i = 0
      while i < times
        s.new_slow_blank?
        i += 1
      end
    end

    x.compare!
  end
end

# ================== Test String Length: 0 ==================
# Warming up --------------------------------------
#      Fast Blank Java   284.023k i/100ms
#           Slow Blank   192.986k i/100ms
#       New Slow Blank   290.646k i/100ms
# Calculating -------------------------------------
#      Fast Blank Java     55.900M (± 9.5%) i/s -    275.218M in   4.997932s
#           Slow Blank      5.710M (± 5.9%) i/s -     28.562M in   5.021554s
#       New Slow Blank     33.295M (±10.9%) i/s -    163.052M in   4.999298s
# 
# Comparison:
#      Fast Blank Java: 55899919.8 i/s
#       New Slow Blank: 33295457.1 i/s - 1.68x  slower
#           Slow Blank:  5710375.9 i/s - 9.79x  slower
# 
# 
# ================== Test String Length: 6 ==================
# Warming up --------------------------------------
#      Fast Blank Java   271.907k i/100ms
#           Slow Blank   142.502k i/100ms
#       New Slow Blank   228.848k i/100ms
# Calculating -------------------------------------
#      Fast Blank Java     29.466M (±14.0%) i/s -    143.023M in   5.004893s
#           Slow Blank      2.741M (± 4.5%) i/s -     13.680M in   5.003036s
#       New Slow Blank      8.713M (± 6.2%) i/s -     43.481M in   5.011576s
# 
# Comparison:
#      Fast Blank Java: 29466276.8 i/s
#       New Slow Blank:  8713135.2 i/s - 3.38x  slower
#           Slow Blank:  2740917.7 i/s - 10.75x  slower
# 
# 
# ================== Test String Length: 14 ==================
# Warming up --------------------------------------
#      Fast Blank Java   288.228k i/100ms
#           Slow Blank   193.662k i/100ms
#       New Slow Blank   202.398k i/100ms
# Calculating -------------------------------------
#      Fast Blank Java     47.185M (± 9.6%) i/s -    232.600M in   5.002948s
#           Slow Blank      5.284M (± 6.9%) i/s -     26.338M in   5.013067s
#       New Slow Blank      6.316M (± 3.9%) i/s -     31.574M in   5.007293s
# 
# Comparison:
#      Fast Blank Java: 47184936.5 i/s
#       New Slow Blank:  6315863.6 i/s - 7.47x  slower
#           Slow Blank:  5284184.1 i/s - 8.93x  slower
# 
# 
# ================== Test String Length: 24 ==================
# Warming up --------------------------------------
#      Fast Blank Java   279.053k i/100ms
#           Slow Blank   146.723k i/100ms
#       New Slow Blank   201.917k i/100ms
# Calculating -------------------------------------
#      Fast Blank Java     35.628M (± 9.4%) i/s -    175.803M in   5.004226s
#           Slow Blank      2.979M (± 4.6%) i/s -     14.966M in   5.035114s
#       New Slow Blank      6.137M (± 6.0%) i/s -     30.691M in   5.021130s
# 
# Comparison:
#      Fast Blank Java: 35627570.4 i/s
#       New Slow Blank:  6137345.1 i/s - 5.81x  slower
#           Slow Blank:  2979206.5 i/s - 11.96x  slower
# 
# 
# ================== Test String Length: 136 ==================
# Warming up --------------------------------------
#      Fast Blank Java   277.245k i/100ms
#           Slow Blank   148.431k i/100ms
#       New Slow Blank   203.430k i/100ms
# Calculating -------------------------------------
#      Fast Blank Java     35.853M (± 7.9%) i/s -    177.714M in   5.003505s
#           Slow Blank      2.982M (± 5.1%) i/s -     14.992M in   5.042856s
#       New Slow Blank      6.183M (± 5.0%) i/s -     30.921M in   5.015464s
# 
# Comparison:
#      Fast Blank Java: 35853197.9 i/s
#       New Slow Blank:  6183303.9 i/s - 5.80x  slower
#           Slow Blank:  2982078.8 i/s - 12.02x  slower
# 
# 
