# Trabalho Final - Administração de Banco de Dados

Este repositório contém o trabalho final de Administração de Banco de Dados, desenvolvido para o curso de [Nome do Curso ou Instituição]. O trabalho consiste na modelagem e implementação de um banco de dados para uma locadora de veículos fictícia chamada **NewtonLoc**, abordando a criação de tabelas, inserção de dados, consultas SQL, triggers, usuários e muito mais.

## Estrutura do Repositório

O repositório está organizado da seguinte forma:

### 1. **Criação do Banco de Dados**
O primeiro conjunto de scripts SQL inclui a criação do banco de dados `NewtonLoc`, com a definição de seu esquema e tabelas principais:

- **CLIENTES**: Tabela que armazena informações sobre os clientes da locadora.
- **CARROS**: Tabela que armazena dados sobre os carros disponíveis para locação.
- **DIMENSOES**: Tabela que contém as dimensões detalhadas de cada carro.
- **LOCACAO**: Tabela que registra as locações realizadas pelos clientes.

Esses scripts podem ser executados para criar a estrutura inicial do banco de dados e definir as tabelas necessárias.

### 2. **Inserção de Dados**
A segunda parte do repositório contém scripts SQL para inserir dados nas tabelas, como clientes, carros e locações. Isso simula um conjunto de dados realista para a locadora, incluindo informações de carros, clientes e locações realizadas.

- **Exemplo de Clientes**: Teclaudio Screen, Maria Teclas, Jonas Mouse, entre outros.
- **Exemplo de Carros**: Fiat Toro, Toyota Yaris, Ford Fiesta, etc.
- **Exemplo de Locações**: Relacionando clientes aos carros alugados com valores e datas de locação.

### 3. **Consultas SQL**
O repositório inclui as respostas a diversas questões sobre o banco de dados, formuladas como **views**. Essas consultas fornecem informações valiosas sobre a locadora, como quais carros foram alugados, quem são os clientes que alugaram carros, quais carros têm a maior potência, entre outras.

As questões incluem:

- Qual o modelo do carro que já foi alugado?
- Qual o nome do cliente que alugou o carro mais caro?
- Quais carros ainda não foram alugados?
- Quais clientes nunca alugaram um carro de determinado ano?

### 4. **Triggers e Funções**
Foram criadas triggers para o monitoramento de alterações e inserções nas tabelas, bem como para controlar a quilometragem dos carros alugados.

- **Trigger de Monitoramento**: Registra informações sobre quem fez uma alteração na tabela `LOCACAO`.
- **Trigger de Gestão de Quilometragem**: Calcula o valor adicional de quilometragem para carros alugados, caso o limite seja ultrapassado.

### 5. **Gestão de Usuários**
O trabalho inclui a criação de **usuários** com diferentes permissões de acesso ao banco de dados. São 10 usuários criados, com permissões variadas:

- Acesso somente para leitura.
- Permissão para inserir dados na tabela de carros.
- Permissões completas no sistema.
- Permissão para criar, alterar e excluir tabelas.

### 6. **Índices**
Foram criados índices para melhorar o desempenho das consultas no banco de dados, otimizando operações de busca e manipulação de dados nas tabelas principais.

### 7. **Procedures**
Inclui a criação de **procedures** (procedimentos armazenados) com temas livres, para automatizar e encapsular operações no banco de dados, como cálculos de preços, atualizações em massa, entre outras.

### 8. **Consultas com JOIN**
Foram criadas 20 consultas SQL usando **JOIN** para responder a diversas questões, como relacionar clientes a carros alugados, encontrar informações sobre os carros e seus locatários, e assim por diante.

## Como Rodar o Projeto

Para rodar os scripts:

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/nome-do-repositorio.git
