require 'rubygems'
require 'pg'

conn = PG.connect(dbname: ARGV[0])

# Now we open the file of all the authors
f = File.open(ARGV[1], "r")
f.each_line do |line|
  # Main author Creation
  nome = line.split(',').to_a.first.split('_').join(' ')
  bolsa = line.split(',').to_a.last
  # We push the main author_data to the db
  conn.exec("UPDATE authors SET tipo_bolsa = '#{bolsa}' WHERE author_name = '#{nome}' ")
end
f.close
