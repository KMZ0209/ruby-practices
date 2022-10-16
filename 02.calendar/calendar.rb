require 'date'
require 'optparse'

today = Date.today
params = ARGV.getopts('m:y:')
year = (params['y']&.to_i || today.year)
month = (params['m']&.to_i || today.month)
first_day = Date.new(year, month)
last_day = Date.new(year, month, -1)
title = " #{month}月 #{year} "

if year < 1 || year > 9999
  puts "cal: year `#{params['y']}' not in range 1..9999"
  return
end

if month < 1 || month > 12
  puts "cal: #{params['m']} is neither a month number (1..12) nor a name"
  return
end

puts title.center(20)
puts "日 月 火 水 木 金 土".center(10)
print " " * 3 * first_day.wday
wday = first_day
(first_day..last_day).each do |date|
  print date.day.to_s.center(3)
    if date.saturday? 
      puts "\n"
    end
end



