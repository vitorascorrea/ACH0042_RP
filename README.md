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
