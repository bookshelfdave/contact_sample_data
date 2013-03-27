require 'CSV'
require 'json'
require 'json/add/core'

class Goog < Struct.new(:date, :open, :high, :low, :close, :volume, :adj); end

puts "use bucket \"Google\";";

CSV.foreach("goog.csv", :headers => true) do |row|
  item = Goog.new(row["Date"],
                  row["Open"],
                  row["Hight"],
                  row["Low"],
                  row["Close"],
                  row["Volume"],
                  row["Adj Close"])
  puts "store \"#{row["Date"]}\" with json ~%~"
  puts JSON.pretty_generate(item)
  puts "~%~;"
  puts " "
end

