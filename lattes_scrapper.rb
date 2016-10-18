require 'rubygems'
require 'watir-webdriver'
require 'phantomjs'
require 'pg'

# Set the path to phantomjs.exe
Selenium::WebDriver::PhantomJS.path = Phantomjs.path.to_s

# Now you can use :phantomjs as the browser type
browser = Watir::Browser.new :phantomjs
# We create a parallel browser to get the co author code
url_sniffer = Watir::Browser.new :phantomjs

conn = PG.connect(dbname: ARGV[0])

conn.exec("SELECT author_code FROM (SELECT author_code FROM authors EXCEPT (SELECT author_code FROM authors LIMIT 8017)) AS authors_subquery").each do |author|
  # Now we look in Lattes for every co author of the main author
  puts "Inserting for author #{author["author_code"]}"
  begin
    browser.goto("http://buscatextual.cnpq.br/buscatextual/graficos.do?metodo=apresentar&codRHCript=#{author['author_code']}")
  rescue
    puts "Tentando reconectar"
    retry
  end
  # We check if the main author has data on lattes
  begin
    if not (browser.text.include? "Não existem produções cadastradas para este currículo")
      browser.execute_script("abreListagemCompleta('porCoAutor');")
      # If it have, we browse the co authors table
      if browser.table(:id, "list_co-autor").wait_until_present
        table = browser.table(:id, "list_co-autor")
        table_array = Array.new
        table.rows.each_with_index do |row, index_r|
          # We skip the first row (titles)
          if(index_r == 0)
            next
          end

          row_array = Array.new

          row.cells.each_with_index do |cell, index|
            # We skip the first column (just an index for the table)
            if(index == 0)
              next
            end

            if(index == 1)
              cell_text = cell.text.to_s
              if cell_text.include? "'"
                cell_text = cell_text.sub "'", ""
              end
              # Now we check if the co author has a link on lattes
              if cell.link(:title, "Currículo Lattes").exists?
                # If yes, we use our parallel browser to fetch the author code from the url
                url_sniffer.goto(cell.link(:title, "Currículo Lattes").href)
                co_author_code = url_sniffer.url.to_s.reverse[0...10].reverse
                row_array << {:co_author_name => cell_text, :co_author_code => co_author_code}
              else
                row_array << {:co_author_name => cell_text, :co_author_code => "No code"}
              end
            end

            if(index == 2)
              row_array << {:num_of_articles => cell.text}
            end


          end
          # We merge the row array into a single hash and push to the table array
          row_array = row_array.inject(:merge)
          conn.exec("INSERT INTO co_authors (main_author_code, co_author_code, co_author_name, num_articles) VALUES ('#{author['author_code']}', '#{row_array[:co_author_code]}', '#{row_array[:co_author_name]}', '#{row_array[:num_of_articles]}' )")
          puts "Inserted co author #{row_array[:co_author_name]}"
        end
      end
    end
  rescue
    next
  end
end
