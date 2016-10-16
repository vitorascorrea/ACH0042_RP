require 'rubygems'
require 'pg'

conn = PG.connect(dbname: ARGV[0])

# Now we open the file of all the authors
f = File.open(ARGV[1], "r")
f.each_line do |line|
  # Main author Creation
  author = []
  array = line.split(',').to_a
  author_data = {
    :author_code => array[0],
    :author_name => array[1].split('_').join(' ')
  }
  if author_data[:author_name].include? "'"
    author_data[:author_name] = author_data[:author_name].sub "'", ""
  end
  # We push the main author_data to the db
  conn.exec("INSERT INTO authors (author_code, author_name) VALUES ('#{author_data[:author_code]}', '#{author_data[:author_name]}')")
  puts "Inserted author #{author_data[:author_name]}"
end
f.close
