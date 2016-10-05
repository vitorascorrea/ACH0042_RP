require 'rubygems'
require 'mechanize'

data_structure = []

#iterate through each author page until we reach all the network (we will use mechanize for online scrapping)
doc = Nokogiri::HTML(open("#{Dir.pwd.to_s}/digiampietri.html"), nil, Encoding::UTF_8.to_s)

#since lattes articles have the css class artigo-completo, we iterate through all nodes that have this class
doc.css('div.artigo-completo').each do |article|
  data = {:main_author => "", :year => "", :article_title => "", :co_authors => ""}
  #main author name
  data[:main_author] = article.css("span[data-tipo-ordenacao=autor]").text
  #year
  data[:year] = article.css("span[data-tipo-ordenacao=ano]").text
  #article name
  data[:article_title] = article.css("div[cvuri]").to_s.split('titulo=')[1].split('&amp;sequencial')[0]
  data_structure.push(data)
end

agent = Mechanize.new

data_structure.each do |data|
  #Get the google scholar page and the main form
  page = agent.get 'https://scholar.google.com.br/'
  google_form = page.form('f')

  #Fill the search form with the article name
  google_form.q = data[:article_title]

  #Submit form
  page = agent.submit(google_form, google_form.buttons.first)

  puts data[:article_title]

  #Get authors
  if page.css('.gs_a').text != nil
    data[:authors] = page.css('.gs_a').text.split(' - ').first.split(', ')
  end

  #Get number of citations
  if page.link_with(:text => /Citado por/).to_s != nil
    data[:citations] = page.link_with(:text => /Citado por/).to_s.split(' ').last.to_i
  end
end

puts data_structure
