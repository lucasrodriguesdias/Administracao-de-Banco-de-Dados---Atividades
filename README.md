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

### **PERGUNTAS DO TRABALHO**

**1 - Crie a estrutura do schema e tabelas da empresa NewtonLoc. O esquema está abaixo e
pode rodar ele todo de uma vez:**
DROP SCHEMA IF EXISTS `NewtonLoc`;
CREATE SCHEMA `NewtonLoc`;
USE `NewtonLoc`;
-- -----------------------------------------------------
-- Table `lojaCarros`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE `CLIENTES` (
`idCliente` INT NOT NULL
AUTO_INCREMENT,
`nome` VARCHAR(45) NOT NULL,
`cpf` CHAR(11) NOT NULL,
`telefone` CHAR(11) NOT NULL,
`email` VARCHAR(45) NOT NULL,
`pontuacao` INT NOT NULL,
`tipo` VARCHAR(45) NOT NULL,
PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `LojaCarros`.`Carros`
-- -----------------------------------------------------
CREATE TABLE`CARROS` (
`idCarro` INT NOT NULL
AUTO_INCREMENT,
`fabricante` VARCHAR(45) NOT NULL,
`modelo` VARCHAR(45) NOT NULL,
`cor` VARCHAR(15) NOT NULL,
`anoFabricacao` YEAR NOT NULL,
`potenciaMotor` DECIMAL(4,1) NOT NULL,
`categoria` VARCHAR(45) NOT NULL,
`quilometragem` BIGINT NOT NULL,
PRIMARY KEY (`idCarro`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `LojaCarros`.`DadosVeiculo`
-- -----------------------------------------------------
CREATE TABLE`DIMENSOES` (
`idDimensao` INT AUTO_INCREMENT,
`altura_mm` DECIMAL(4,3) NOT NULL,
`largura_mm` DECIMAL(4,3) NOT NULL,
`comprimento_mm` DECIMAL(4,3) NOT
NULL,
`peso_kg` INT NOT NULL,
`tanque_L` INT NOT NULL,
`entre_eixos_mm` DECIMAL(4,3) NOT
NULL,
`porta_mala_L` INT NOT NULL,
`ocupante` INT NOT NULL,
`fk_idCarro` INT NOT NULL,
CONSTRAINT `fk_Dimensoes_Carros`
FOREIGN KEY (`fk_idCarro`)
REFERENCES `CARROS` (`idCarro`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
PRIMARY KEY (`idDimensao`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `LojaCarros`.`Locacao`
-- -----------------------------------------------------
CREATE TABLE `LOCACAO` (
`idLocacao` INT NOT NULL
AUTO_INCREMENT,
`dataLocacao` DATE NOT NULL,
`valorDiaria` DOUBLE NOT NULL,
`fk_idCliente` INT NOT NULL,
`fk_idCarro` INT NOT NULL,
PRIMARY KEY (`idLocacao`),
CONSTRAINT `fk_Locacao_Clientes`
FOREIGN KEY (`fk_idCliente`)
REFERENCES `CLIENTES` (`idCliente`)
ON DELETE NO ACTION
ON UPDATE NO ACTION,
CONSTRAINT `fk_Locacao_Carros`
FOREIGN KEY (`fk_idCarro`)
REFERENCES `CARROS`(`idCarro`)
ON DELETE NO ACTION
ON UPDATE NO ACTION)
ENGINE = InnoDB;

**2 – Insira os dados nas tabelas da empresa NewtonLoc. O DML está abaixo e pode rodar ele todo de uma
vez:** OBS: A tabela DIMENSÕES DEVE SER ALIMENTADA SEPARADAMENTE. OS DADOS PARA
ALIMENTA-LA ESTÃO NA SEQUENCIA:
INSERT INTO CLIENTES (nome,cpf,telefone,email,pontuacao,tipo)values
('Teclaudio Screen','12341234121','31987655434','te@gmail.com',0,'Basico'),
('Maria Teclas','12332143445','32987800987','m@gmail.com',100,'Basico'),
('Jonas Mouse','44489865432','31976533234','mouse@gmail.com',500,'Basico'),
('Carlos CPU','45609087678','31978900627','cpu@gmail.com',1200,'Intemediario'),
('Tiana Cooler','67512399900','31976432111','ti@gmail.com',3000,'Intermediario'),
('Cassandra Pixel','88890097666','31980077654','cas@gmail.com',5600,'Premium');
INSERT INTO CARROS
(fabricante,modelo,cor,anoFabricacao,potenciaMotor,categoria,quilometragem)values
('Fiat','Toro Freedom','preto','2022',1.8,'SUV',12000),
('Toyota','Yaris','Branco','2022',1.5,'Sedan',3000),
('Ford','Fiesta','Branco','2021',1.6,'Hatch',566),
('Toyota','Corolla','Branco','2023',2.0,'Sedan',1022),
('Hyundai','Hb20','Vermelho','2023',2.0,'Hatch',300),
('Volksvagen','Gol','Verde','2020',1.6,'Hatch',5059),
('Chevrolet','Onix','preto','2019',1.6,'Hatch',12034);
INSERT INTO locacao(dataLocacao,valorDiaria,fk_idCliente,fk_idCarro)
values
('2023-01-10',123,1,1),
('2023-01-10',183,2,2),
('2023-01-10',100,3,3),
('2023-01-10',199,4,4),
('2023-01-10',99,5,5),
('2023-02-10',183,2,2);

Dados para alimentar a tabela dimensões:
Dimensoes gol
Altura (mm) 1.475
Largura (mm) 1.656
Comprimento (mm) 3.892
Peso (Kg) 1.020
Tanque (L) 55
Entre-eixos (mm) 2.467
Porta-Malas (L) 285
Ocupantes 5

Dimensoes corolla
Altura (mm) 1.480
Largura (mm) 1.760
Comprimento (mm) 4.540
Peso (Kg) 1.230
Tanque (L) 60
Entre-eixos (mm) 2.600
Porta-Malas (L) 470
Ocupantes 5

Dimensoes toro
Altura (mm) 1.673
Largura (mm) 1.844
Comprimento (mm) 4.945
Peso (Kg) 1.650
Tanque (L) 55
Entre-eixos (mm) 2.982
Porta-Malas (L) 0
Ocupantes 5

Dimensoes fiesta
Altura (mm) 1.487
Largura (mm) 1.765
Comprimento (mm) 3.935
Peso (Kg) 1.084
Tanque (L) 54
Entre-eixos (mm) 2.488
Porta-Malas (L) 270
Ocupantes 5

Dimensões yaris
Altura (mm) 1.490
Largura (mm) 1.730
Comprimento (mm) 4.425
Peso (Kg) 1.130
Tanque (L) 45
Entre-eixos (mm) 2.550
Porta-Malas (L) 473
Ocupantes 5

Dimensões hb20
Altura (mm) 1.470
Largura (mm) 1.720
Comprimento (mm) 4.015
Peso (Kg) 993
Tanque (L) 50
Entre-eixos (mm) 2.530
Porta-Malas (L) 300
Ocupantes 5

Dimensões onix
Altura (mm) 1.471
Largura (mm) 1.731
Comprimento (mm) 4.163
Peso (Kg) 1.034
Tanque (L) 44
Entre-eixos (mm) 2.551
Porta-Malas (L) 303
Ocupantes 5

**3 Agora as perguntas a serem respondidas com o schema todo pronto: Crie 1 View para cada uma das
perguntas**
Questao 1 -- Qual o modelo do carro que já foi alugado
Questao 2 -- Qual o nome do cliente que já alugou um carro
Questao 3 -- Qual o nome do cliente que alugou o carro com a diária mais alta.
Questao 4-- Qual a categoria do carro que foi alugado por ultimo
Questao 5 -- Qual o nome do fabricante(s) que produziu o carro(s) mais potente(s)
Questao 6 -- Qual a cor da SUV locada no dia 2024-10-22
Questao 7 -- Qual o modelo do carro, fabricante, cor que tem a menor diária
Questao 8 -- Qual o modelo do carro e categoria que não foi alugado ainda
Questao 9 -- Qual o nome do cliente que nunca alugou um carro do ano de fabricao 2013
Questao 10 -- Qual o nome do cliente que já alugou um carro SUV
Questao 11 -- Qual o nome do cliente que NÃO alugou um carro Sedan
Questao 12 -- Qual a categoria do cliente que já alugou um carro com mais de 3000 quilômetros rodados
Questao 13 -- Qual o modelo do carro que tem a menor altura.
Questao 14 -- Qual o tamanho do porta mala do carro que é da categoria Hatch
Questao 15 – Você deve criar mais 10 sub Consultas nesse sistema.

**4. Crie uma trigger para monitorar a tabela locação. Ela deve registrar os dados do usuário, data de
inserção de um registro, e quais foram os dados novos inseridos. Para isso crie uma tabela chamada log.**

**5. Analise o database e suas tabelas para implementar uma trigger que possa fazer a gestão da
quilometragem dos carros que foram alugados. Exemplo: Aluguei um gol com quilometragem de 2344
quilômetros e só posso rodar 1000 quilômetros, se ao entregar o carro ele estiver com quilometragem de
mais que 3344, meu valor do quilometro deve subir pra 30% a mais. Você deve mudar o que for preciso
para atender a demanda passada. Se achar necessário, use uma tabela pra devolução com os valores
extras nela.**

**6. Crie 10 usuários com senha para acessar (Roles) conforme as restrições abaixo (Você decide quem
acessa o que) cada acesso é uma Role**
• Acesso1 - Apenas para dar select em todas as tabelas.
• Acesso2 - Apenas Select e insert na tabela de carros
• Acesso3 - Total no Sistema e database.
• Acesso4 - Create, alter e drop em tabelas e schema.
• Acesso5 - Total ao schema.

**7. Entre os usuários criados acima, altere as permissões de 5. A sua escolha.**

**8. Crie um índice para cada uma das tabelas acima.**

**9. Crie 20 perguntas e 20 respostas onde as respostas devem ser todas com Join.**

**10. Crie 10 procedures com tema livre.**


## Como Rodar o Projeto

Para rodar os scripts:

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/nome-do-repositorio.git
