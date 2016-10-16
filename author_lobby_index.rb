require 'rubygems'
require 'pg'

conn = PG.connect(dbname: ARGV[0])
lobby_query = "SELECT COUNT(*) AS degree FROM co_authors WHERE main_author_code IN
            	(SELECT co_author_code FROM co_authors WHERE main_author_code = '#{ARGV[1]}')
            GROUP BY main_author_code
            ORDER BY degree"

co_authors_select = conn.exec(lobby_query).to_a

#Since our select doesnt show values = 0, we search for the minimum degree
min_value = 99999
co_authors_select.each do |a|
  if a['degree'].to_i < min_value
    min_value = a['degree'].to_i
  end
end

#Now we try to find the lobby index base on the definition: The l-index or lobby index of a node x is the largest integer
#k such that x has at least k neighbors with a degree of at least k.

#Here we set our variables
lobby_index = min_value
current_neighbors = co_authors_select
num_neighbors = 0

#Now we loop, adding +1 on the lobby index until its value is lower than the number of neighbors that can have the degree
while true
  current_neighbors.each do |co_author|
    if co_author['degree'].to_i > lobby_index
      num_neighbors = num_neighbors + 1
    end
  end
  if num_neighbors > lobby_index
    lobby_index = lobby_index + 1
    num_neighbors = 0
  else
    break
  end
end

puts "The lobby index for author #{ARGV[1]} is #{lobby_index}"
