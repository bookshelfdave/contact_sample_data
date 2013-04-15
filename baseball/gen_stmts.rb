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

puts "connect \"127.0.0.1\" pb 10017;"
puts ""

class Master < Struct.new(:lahmanID,:playerID,:managerID,:hofID,:birthYear,:birthMonth,:birthDay,:birthCountry,:birthState,:birthCity,:deathYear,:deathMonth,:deathDay,:deathCountry,:deathState,:deathCity,:nameFirst,:nameLast,:nameNote,:nameGiven,:nameNick,:weight,:height,:bats,:throws,:debut,:finalGame,:college,:lahman40ID,:lahman45ID,:retroID,:holtzID,:bbrefID); end

puts "use bucket \"BaseballMaster\";"
puts ""

CSV.foreach("Master.csv", :headers => true, :encoding => "ISO8859-1") do |row|
  item = Master.new(
    row["lahmanID"],
    row["playerID"],
    row["managerID"],
    row["hofID"],
    row["birthYear"],
    row["birthMonth"],
    row["birthDay"],
    row["birthCountry"],
    row["birthState"],
    row["birthCity"],
    row["deathYear"],
    row["deathMonth"],
    row["deathDay"],
    row["deathCountry"],
    row["deathState"],
    row["deathCity"],
    row["nameFirst"],
    row["nameLast"],
    row["nameNote"],
    row["nameGiven"],
    row["nameNick"],
    row["weight"],
    row["height"],
    row["bats"],
    row["throws"],
    row["debut"],
    row["finalGame"],
    row["college"],
    row["lahman40ID"],
    row["lahman45ID"],
    row["retroID"],
    row["holtzID"],
    row["bbrefID"],
  )

  puts "store \"#{row["playerID"]}\""
  puts "  with index \"lahmanID_bin\" = \"#{row["lahmanID"]}\" "
  puts "  and index \"nameLast\" = \"#{row["nameLast"]}\" "
  puts "  and index \"nameFirst\" = \"#{row["nameFirst"]}\" "
  puts "  and json "
  puts "~%~"
  puts JSON.pretty_generate(item)
  puts "~%~;"
end

