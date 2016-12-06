require 'rubygems'
require 'pg'

conn = PG.connect(dbname: ARGV[0])

authors = conn.exec("SELECT author_name, author_code FROM authors")

authors.each do |author|

  co_authors = conn.exec("SELECT co_author_name, co_author_code FROM co_authors WHERE main_author_code = '#{author['author_code']}' AND co_author_code != 'No code'")

  co_authors_degree = []
  co_authors.each do |co_author|
    degree = conn.exec("SELECT COUNT(*) AS degree FROM co_authors WHERE main_author_code = '#{co_author['co_author_code']}' AND co_author_code != 'No code'").to_a[0]['degree']
    hash = {:co_author_code => co_author['co_author_code'], :co_author_degree => degree.to_i}
    co_authors_degree << hash
  end

  co_authors_degree.sort_by! { |hsh| hsh[:co_author_degree] }.reverse!

  #Now we try to find the lobby index base on the definition: The l-index or lobby index of a node x is the largest integer
  #k such that x has at least k neighbors with a degree of at least k.

  lobby_index = 1
  co_authors_degree.each_with_index do |co_author, index|
    if co_author[:co_author_degree].to_i >= index + 1
      lobby_index = index + 1
    else
      break
    end
  end

  puts "Inserindo lobby index #{lobby_index} do autor #{author['author_code']}"
  conn.exec("UPDATE authors SET lobby_index = #{lobby_index} WHERE author_code = '#{author['author_code']}'")
end
