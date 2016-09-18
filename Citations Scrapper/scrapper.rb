require 'rubygems'
require 'mechanize'

data_structure = [
  {:article_title => 'Lobby index as a network centrality measure', :citations => 0, :authors => ''},
  {:article_title => 'A new method of identifying influential nodes in complex networks based on TOPSIS', :citations => 0, :authors => ''}
]

#Create the Mechanize agent
agent = Mechanize.new

data_structure.each do |data|
  #Get the google scholar page and the main form
  page = agent.get 'https://scholar.google.com.br/'
  google_form = page.form('f')

  #Fill the search form with the article name
  google_form.q = data[:article_title]

  #Submit form
  page = agent.submit(google_form, google_form.buttons.first)

  #Get authors
  data[:authors] = page.css('.gs_a').text.split(' - ').first.split(', ')

  #Get number of citations
  data[:citations] = page.link_with(:text => /Citado por/).to_s.split(' ').last.to_i
end

puts data_structure
