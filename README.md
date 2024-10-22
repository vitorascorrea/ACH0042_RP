ACH0042 - Resolução de Problemas
=======

Projeto de RP com o objetivo final de implementar uma automatização do lobby index em redes de doutores da área de Ciência da Computação.

**Instruções de Instalação (Ubuntu)**

1. Clone o projeto.

2. `sudo apt-get install ruby`

3. Ter o postgreSQL instalado e instalar o header: `sudo apt-get install libpq-dev`

3. `cd` na pasta do projeto, instale as dependencias `gem install watir-webdriver`, `gem install phantomjs`, `gem install pg`

4. Execute o comando no terminal: `ruby install-phantomjs.rb`

5. Para a mineração de dados de autores, rode no terminal:`ruby author_reader.rb <NOME_DO_BANCO> <NOME_DO_ARQUIVO_DE_AUTORES>` (obs: o formato de arquivo de autores tem que ser identico ao arquivo `autores_bolsa.txt`)

6. Para a mineração de dados de co-autores, rode no terminal:`ruby lattes_scrapper.rb <NOME_DO_BANCO>` (obs: o nome do banco deve ser o mesmo nos passos 5 e 6 e ter a estrutura descrita no arquivo `schema.sql`)

7. Para inserir o lobby index de todos os autores `ruby insert_lobby_index_all.rb <NOME_DO_BANCO>`

8. Para inserir o h index do Google Scholar de todos os autores `ruby google_scholar_scrapper.rb <NOME_DO_BANCO>`

9. Para inserir a bolsa de produtividade de todos os autores `ruby productive_bags.rb <NOME_DO_BANCO> <NOME_DO_ARQUIVO_DE_BOLSAS>`
(obs: o formato de arquivo de autores tem que ser identico ao arquivo `bolsa.csv`)

8. Para inserir a nacionalidade, início e fim de doutorado de todos os autores `ruby phd_time.rb <NOME_DO_BANCO> <NOME_DO_ARQUIVO_DE_DOUTORES>`
(obs: o formato de arquivo de autores tem que ser identico ao arquivo `doutorado.csv`)
