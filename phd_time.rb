require 'rubygems'
require 'pg'

conn = PG.connect(dbname: ARGV[0])

# Now we open the file of all the authors
f = File.open(ARGV[1], "r")
f.each_line do |line|
  # Main author Creation
  nome = line.split(',')[0].split('\'').join('')
  nationality = line.split(',')[1]
  beginning = line.split(',')[2]
  ending = line.split(',')[3]
  # We push the main author_data to the db
  conn.exec("UPDATE authors SET nationality = '#{nationality}', doc_begin = '#{beginning}', doc_end = '#{ending}' WHERE author_name = '#{nome}' ")
  puts "inserido #{nome}"
end
f.close
