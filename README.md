# README #

## Dependencias ##
### ruby `2.3.4`
### PostgresSql `9.5`
* Siga as instruções de instalação e utilização no site: http://postgresapp.com/

## Setup da aplicação
* copiar config/database.yml.sample para config/database.yml
* configurar config/database.yml para as configurações da sua database
* $ ./bin/setup

## rodando os testes
* rspec spec


## TASK LIST
* Setup da aplicação
* Configurar rotas
* Criar model do usuário
* Criar model de endereço
* Criar serviço de busca de endereço por CEP
* Criar CRUD Json


## TODO LIST
* Tornar configurável o endpoint de busca de endereços
* Colocar o cache dos endereços em memcached e deixar de buscar no banco
* colocar swagger para documentar a api
