require 'CSV'
require 'date'
require 'json'
require 'json/add/core'

class Struct
  def to_map
    map = Hash.new
    self.members.each { |m| map[m] = self[m] }
    map
  end

  def to_json(*a)
    to_map.to_json(*a)
  end
end

class Goog < Struct.new(:date, :open, :high, :low, :close, :volume, :adj); end

puts "connect \"127.0.0.1\" pb 10017;"
puts ""
puts "use bucket \"Google\";"
puts ""

CSV.foreach("goog.csv", :headers => true) do |row|
  date = Date.strptime(row["Date"],"%Y-%m-%d")
  item = Goog.new(row["Date"],
                  row["Open"],
                  row["High"],
                  row["Low"],
                  row["Close"],
                  row["Volume"],
                  row["Adj Close"])
  puts "store \"#{row["Date"]}\""
  puts "  with index \"year_int\" = \"#{date.year}\" "
  puts "  and json "
  puts "~%~"
  puts JSON.pretty_generate(item)
  puts "~%~;"
end

