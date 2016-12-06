require 'rubygems'
require 'watir-webdriver'
require 'phantomjs'
require 'pg'

# Set the path to phantomjs.exe
Selenium::WebDriver::PhantomJS.path = Phantomjs.path.to_s

# Now you can use :phantomjs as the browser type
browser = Watir::Browser.new :phantomjs

require 'rubygems'
require 'pg'

conn = PG.connect(dbname: ARGV[0])

authors = conn.exec("SELECT * FROM authors WHERE google_h_index IS NULL")

authors.each do |author|
  author_formated_name = author['author_name'].clone
  author_formated_name = author_formated_name.to_s.gsub!(' ', '+')
  begin
    browser.goto("https://scholar.google.com/citations?mauthors=#{author_formated_name}&hl=en&view_op=search_authors")
  rescue
    puts "Tentando reconectar"
    retry
  end

  if browser.text.include? "didn't match any user profiles"
    conn.exec("UPDATE authors SET google_h_index = 0 WHERE author_code = '#{author['author_code']}'")
    puts "No code"
    next
  else
    begin
      if author['author_name'].match(/([A-Z]+)/)
        browser.span(:class => "gs_hlt").click
      else
        browser.link(:text => "#{author['author_name']}").click
      end
      h_index = browser.table(:id, 'gsc_rsb_st').row(:index => 2).cell(:index => 1).text.to_i
      conn.exec("UPDATE authors SET google_h_index = #{h_index} WHERE author_code = '#{author['author_code']}'")
      puts "Inserted for author #{author['author_name']}"
    rescue
      puts "Captcha got me"
      browser.cookies.clear
      next
    end
  end
end
