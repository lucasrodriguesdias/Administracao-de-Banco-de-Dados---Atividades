-- Questão 1

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


-- Questão 2

INSERT INTO dimensoes(altura_mm, largura_mm, comprimento_mm, peso_kg, 
tanque_L, entre_eixos_mm, porta_mala_L, ocupante, fk_idCarro)
values
(1.475, 1.656, 3.892, 1020, 55, 2.467, 285, 5, 6),
(1.480, 1.760, 4.540, 1230, 60, 2.600, 470, 5, 4),
(1.673, 1.844, 4.945, 1650, 55, 2.982, 0, 5, 1),
(1.487, 1.765, 3.935, 1084, 54, 2.488, 270, 5, 3),
(1.490, 1.730, 4.425, 1130, 45, 2.550, 473, 5, 2),
(1.470, 1.720, 4.015, 993, 50, 2.530, 300, 5, 5),
(1.471, 1.731, 4.163, 1034, 44, 2.551, 303, 5, 7);

-- Questão 3
-- Numero 1

CREATE OR REPLACE VIEW View3_1 AS
SELECT modelo FROM locacao L
INNER JOIN carros C
ON L.fk_idCarro = C.idCarro;
SELECT * FROM View3_1;

-- Numero 2

CREATE OR REPLACE VIEW View3_2 AS
SELECT nome FROM clientes C 
INNER JOIN locacao L 
ON C.idCliente = L.fk_idCliente;
SELECT * FROM View3_2;

-- Numero 3

CREATE OR REPLACE VIEW View3_3 AS
SELECT C.nome FROM clientes C
INNER JOIN locacao L 
ON C.idCliente = L.fk_idCliente 
WHERE L.valorDiaria = (SELECT MAX(L.valorDiaria) FROM locacao L);
SELECT * FROM View3_3;

-- Numero 4 (Guilherme)

-- Numero 5

CREATE OR REPLACE VIEW View3_5 AS
SELECT CA.fabricante FROM carros CA
WHERE CA.potenciaMotor = (SELECT MAX(CA.potenciaMotor)
FROM carros CA);
SELECT * FROM View3_5;

-- Numero 6 (Guilherme)

-- Numero 7

CREATE OR REPLACE VIEW View3_7 AS
SELECT CA.modelo, CA.fabricante, CA.cor FROM carros CA
INNER JOIN locacao L 
ON CA.idCarro = L.fk_idCarro 
WHERE L.valorDiaria = (SELECT MIN(L.valorDiaria) FROM locacao L);
SELECT * FROM View3_7;

-- Numero 8 (Guilherme)

-- Numero 9 

CREATE OR REPLACE VIEW View3_9 AS
SELECT C.nome FROM clientes C 
INNER JOIN locacao L
ON C.idCliente = L.fk_idCliente
INNER JOIN carros CA
ON CA.idCarro = L.fk_idCarro
WHERE CA.anoFabricacao != 2013;
SELECT * FROM View3_9;

-- Numero 10 (Guilherme)

-- Numero 11

CREATE OR REPLACE VIEW View3_11 AS
SELECT C.nome, CA.categoria FROM clientes C 
INNER JOIN locacao L 
ON C.idCliente = L.fk_idCliente
INNER JOIN carros CA 
ON CA.idCarro = L.fk_idCarro
WHERE CA.categoria NOT LIKE '%sedan%';
SELECT * FROM View3_11;

-- Numero 12 (Guilherme)

-- Numero 13 (Guilherme)

-- Numero 14 (Guilherme)

-- Numero 15 
-- #1 Qual o ano de fabricação do carro alugado mais recentemente?

CREATE OR REPLACE VIEW View3_15_1 AS
SELECT CA.anoFabricacao FROM carros CA
INNER JOIN locacao L 
ON CA.idCarro = L.fk_idCarro 
WHERE L.dataLocacao = (SELECT MAX(L.dataLocacao) FROM locacao L);
;
SELECT * FROM View3_15_1;

-- #2 Qual o nome dos clientes que já alugaram carros da mesma categoria 
-- mais de uma vez?

CREATE OR REPLACE VIEW View3_15_2 AS
SELECT C.nome FROM clientes C
INNER JOIN locacao L
ON C.idCliente = L.fk_idCliente
INNER JOIN carros CA
ON CA.idcarro = L.fk_idCarro
GROUP BY C.idCliente, CA.categoria
HAVING COUNT(*) > 1;
SELECT * FROM View3_15_2;

-- #3 Qual o modelo de carro com maior peso que já foi alugado?

CREATE OR REPLACE VIEW View3_15_3 AS
SELECT CA.modelo FROM carros CA
INNER JOIN dimensoes D
ON CA.idCarro = D.fk_idCarro
INNER JOIN locacao L 
ON CA.idCarro = L.fk_idCarro
WHERE D.peso_kg = (SELECT MAX(D.peso_kg) FROM dimensoes D);
SELECT * FROM View3_15_3;

-- #4 Qual o fabricante do carro com o menor tanque em litros entre 
-- os carros que foram alugados?

CREATE OR REPLACE VIEW View3_15_4 AS
SELECT CA.fabricante FROM carros CA 
INNER JOIN dimensoes D
ON CA.idCarro = D.fk_idCarro
INNER JOIN locacao L 
ON CA.idCarro = L.fk_idCarro
WHERE D.tanque_L = (SELECT MAX(D.tanque_L) FROM dimensoes D);
SELECT * FROM View3_15_4;

-- #5 Qual a cor do carro mais antigo que ainda não foi alugado?

CREATE OR REPLACE VIEW View3_15_5 AS
SELECT CA.cor FROM carros CA 
LEFT JOIN locacao L 
ON CA.idCarro = L.fk_idCarro
WHERE L.idLocacao IS NULL AND CA.anoFabricacao = (SELECT MIN(CA.anoFabricacao) FROM carros CA 
												LEFT JOIN locacao L ON CA.idCarro = L.fk_idCarro 
                                                WHERE L.idLocacao IS NULL);
SELECT * FROM View3_15_5;

-- #6 Qual o cliente que mais alugou carros do fabricante Fiat?

CREATE OR REPLACE VIEW View3_15_6 AS
SELECT C.nome FROM clientes C 
INNER JOIN locacao L
ON C.idCLiente = L.fk_idCliente
INNER JOIN carros CA 
ON CA.idCarro = L.fk_idCarro
WHERE CA.fabricante = 'Fiat'
GROUP BY C.idCliente
ORDER BY COUNT(*) DESC
LIMIT 1;
SELECT * FROM View3_15_6;

-- #7 Qual o modelo do carro que possui o menor entre-eixos entre os carros alugados?

CREATE OR REPLACE VIEW View3_15_7 AS
SELECT CA.modelo FROM carros CA 
INNER JOIN dimensoes D
ON CA.idCarro = D.fk_idCarro
INNER JOIN locacao L 
ON CA.idCarro = L.fk_idCarro
WHERE D.entre_eixos_mm = (SELECT MIN(D.entre_eixos_mm) FROM dimensoes D 
						INNER JOIN locacao L2 ON D.fk_idCarro = L2.fk_idCarro);
SELECT * FROM View3_15_7;

-- #8 Qual a quilometragem do carro mais alugado até o momento?

CREATE OR REPLACE VIEW View3_15_8 AS
SELECT CA.quilometragem
FROM carros CA
WHERE CA.idCarro = (SELECT fk_idCarro FROM locacao L
					GROUP BY fk_idCarro
					ORDER BY COUNT(*) DESC
					LIMIT 1);
SELECT * FROM View3_15_8;

-- #9 Qual o peso em kg do carro mais leve entre os que foram alugados em 2023?

CREATE OR REPLACE VIEW View3_15_9 AS
SELECT MIN(D.peso_kg) FROM dimensoes D
INNER JOIN locacao L 
ON D.fk_idCarro = L.fk_idCarro
WHERE YEAR(L.dataLocacao) = 2023;
SELECT * FROM View3_15_9;

-- #10 Qual a cor e o ano do carro com o menor porta-malas 
-- que foi alugado por um cliente Intermediario?

CREATE OR REPLACE VIEW View3_15_10 AS
SELECT CA.cor, CA.anoFabricacao FROM carros CA
INNER JOIN dimensoes D
ON CA.idCarro = D.fk_idCarro
INNER JOIN locacao L 
ON CA.idCarro = L.fk_idCarro
WHERE D.porta_mala_L = (SELECT MIN(D.porta_mala_L) FROM dimensoes D
						INNER JOIN locacao L 
                        ON D.fk_idCarro = L.fk_idCarro
                        INNER JOIN clientes C 
                        ON C.idCliente = L.fk_idCliente
                        WHERE C.tipo = 'Intermediario');
SELECT * FROM View3_15_10;

-- Questão 4
CREATE TABLE log (
    usuario VARCHAR(250) NOT NULL,
    dataRegistro DATETIME NOT NULL,
    idLocacao INT NOT NULL,
    dataLocacao DATE NOT NULL,
    valorDiaria DOUBLE NOT NULL,
    fk_idCliente INT NOT NULL,
    fk_idCarro INT NOT NULL
);

DELIMITER $$
CREATE TRIGGER monitoraLocacao 
AFTER INSERT ON locacao
FOR EACH ROW 
BEGIN
	INSERT INTO log(usuario, dataRegistro, idLocacao, dataLocacao, valorDiaria,
        fk_idCliente, fk_idCarro)
	VALUES (USER(), NOW(), NEW.idLocacao, NEW.dataLocacao, NEW.valorDiaria,
        NEW.fk_idCliente, NEW.fk_idCarro);
END $$
DELIMITER ;

-- Testar a trigger
INSERT INTO locacao (idLocacao, dataLocacao, valorDiaria,
        fk_idCliente, fk_idCarro)
VALUES (7, '2024-11-10', 200, 4, 2);

SELECT * FROM log;

-- Questão 5 (Guilherme)

-- Questão 6
-- Criando os roles (acessos 1 ao 5)
CREATE ROLE Acesso1;
GRANT SELECT ON newtonloc.* TO Acesso1;
SHOW GRANTS FOR Acesso1;

CREATE ROLE Acesso2;
GRANT SELECT, INSERT ON newtonloc.carros TO Acesso2;
SHOW GRANTS FOR Acesso2;

CREATE ROLE Acesso3;
GRANT ALL ON newtonloc.* TO Acesso3;
SHOW GRANTS FOR Acesso3;

CREATE ROLE Acesso4;
GRANT CREATE, ALTER, DROP ON newtonloc.* TO Acesso4;
SHOW GRANTS FOR Acesso4;

CREATE ROLE Acesso5;
GRANT ALL ON newtonloc.* TO Acesso5;
SHOW GRANTS FOR Acesso5;

-- Criando usuário e inserindo permissões
CREATE USER 'Lucas' IDENTIFIED BY '123456';
GRANT Acesso5 TO 'Lucas';
SET DEFAULT ROLE Acesso5 TO 'Lucas';
SHOW GRANTS FOR 'Lucas';

CREATE USER 'Guilherme'@'%' IDENTIFIED BY '654321';
GRANT Acesso1 TO 'Guilherme'@'%';
SET DEFAULT ROLE Acesso1 TO 'Guilherme'@'%';
SHOW GRANTS FOR 'Guilherme'@'%';

CREATE USER 'Carlos'@'localhost' IDENTIFIED BY '112233';
GRANT Acesso2 TO 'Carlos'@'localhost';
SET DEFAULT ROLE Acesso2 TO 'Carlos'@'localhost';
SHOW GRANTS FOR 'Carlos'@'localhost';

CREATE USER 'Jefferson' IDENTIFIED BY RANDOM PASSWORD;
GRANT Acesso4 TO 'Jefferson';
SET DEFAULT ROLE Acesso4 TO 'Jefferson';
SHOW GRANTS FOR 'Jefferson';

CREATE USER 'Lorena' IDENTIFIED BY '909090';
GRANT Acesso4, Acesso1 TO 'Lorena';
SET DEFAULT ROLE Acesso4, Acesso1 TO 'Lorena';
SHOW GRANTS FOR 'Lorena';

CREATE USER 'Gabriel'@'localhost' IDENTIFIED BY '654321';
GRANT Acesso3 TO 'Gabriel'@'localhost';
SET DEFAULT ROLE Acesso3 TO 'Gabriel'@'localhost';
SHOW GRANTS FOR 'Gabriel'@'localhost';

CREATE USER 'Carol' IDENTIFIED BY RANDOM PASSWORD;
GRANT Acesso5 TO 'Carol';
SET DEFAULT ROLE Acesso5 TO 'Carol';
SHOW GRANTS FOR 'Carol';

CREATE USER 'Fernanda'@'%' IDENTIFIED BY '414243';
GRANT Acesso2, Acesso4 TO 'Fernanda'@'%';
SET DEFAULT ROLE Acesso2, Acesso4 TO 'Fernanda'@'%';
SHOW GRANTS FOR 'Fernanda'@'%';

CREATE USER 'Ailton' IDENTIFIED BY '250871';
GRANT Acesso5 TO 'Ailton';
SET DEFAULT ROLE Acesso5 TO 'Ailton';
SHOW GRANTS FOR 'Ailton';

CREATE USER 'Michelle'@'localhost' IDENTIFIED BY '010101';
GRANT Acesso1 TO 'Michelle'@'localhost';
SET DEFAULT ROLE Acesso1 TO 'Michelle'@'localhost';
SHOW GRANTS FOR 'Michelle'@'localhost';

-- Questão 7
REVOKE Acesso5 FROM 'Carol';
GRANT Acesso1 TO 'Carol';
SET DEFAULT ROLE Acesso1 TO 'Carol';
SHOW GRANTS FOR 'Carol';

REVOKE Acesso5 FROM 'Ailton';
GRANT Acesso1, Acesso4 TO 'Ailton';
SET DEFAULT ROLE Acesso1, Acesso4 TO 'Ailton';
SHOW GRANTS FOR 'Ailton';

REVOKE Acesso1 FROM 'Michelle'@'localhost';
GRANT Acesso5 TO 'Michelle'@'localhost';
SET DEFAULT ROLE Acesso5 TO 'Michelle'@'localhost';
SHOW GRANTS FOR 'Michelle'@'localhost';

REVOKE Acesso1 FROM 'Guilherme'@'%';
GRANT Acesso5 TO 'Guilherme'@'%';
SET DEFAULT ROLE Acesso5 TO 'Guilherme'@'%';
SHOW GRANTS FOR 'Guilherme'@'%';

GRANT Acesso1 TO 'Jefferson';
SET DEFAULT ROLE Acesso1 TO 'Jefferson';
SHOW GRANTS FOR 'Jefferson';

-- Questão 8



-- Questão 9

-- 1 Liste o nome do cliente e a data da locação de todos os carros que já foram alugados.
USE newtonloc;
SELECT C.nome, L.dataLocacao FROM clientes C 
INNER JOIN locacao L 
ON C.idCliente = L.fk_idCliente
ORDER BY C.nome ASC;

-- 2 Quais os fabricantes e modelos de carros que já foram locados, juntamente com os nomes dos clientes
USE newtonloc;
SELECT CA.fabricante, CA.modelo, C.nome FROM clientes C 
INNER JOIN locacao L
ON C.idCliente = L.fk_idCliente
INNER JOIN carros CA 
ON CA.idCarro = L.fk_idCarro
ORDER BY C.nome ASC;

-- 3 Liste o modelo dos carros e suas dimensões (altura, largura e comprimento) que foram locados.
USE newtonloc;
SELECT CA.modelo, D.altura_mm, D.largura_mm, D.comprimento_mm FROM carros CA 
INNER JOIN locacao L
ON CA.idCarro = L.fk_idCarro
INNER JOIN dimensoes D
ON D.fk_idCarro = L.fk_idCarro
ORDER BY CA.modelo ASC;

-- 4 Quais os nomes dos clientes que alugaram carros da cor vermelha?
USE newtonloc;
SELECT C.nome FROM clientes C
INNER JOIN locacao L
ON C.idCliente = L.fk_idCliente
INNER JOIN carros CA 
ON CA.idCarro = L.fk_idCarro
WHERE CA.cor = 'Vermelho';

-- 5 Liste o nome do cliente e o valor da diária dos carros alugados por eles.
USE newtonloc;
SELECT C.nome, L.valorDiaria FROM clientes C
INNER JOIN locacao L 
ON C.idCliente = L.fk_idCliente
ORDER BY C.nome ASC;

-- 6 Exiba o modelo, a quilometragem e o nome do cliente que alugou carros com potência de motor superior a 1.5.
USE newtonloc;
SELECT CA.modelo, CA.quilometragem, C.nome FROM carros CA 
INNER JOIN locacao L 
ON CA.idCarro = L.fk_idCarro
INNER JOIN clientes C 
ON C.idCliente = L.fk_idCliente
WHERE CA.potenciaMotor > 1.5;

-- 7 Mostre o nome dos clientes e os fabricantes dos carros que alugaram.
USE newtonloc;
SELECT C.nome, CA.fabricante FROM clientes C 
INNER JOIN locacao L 
ON C.idCliente = L.fk_idCliente
INNER JOIN carros CA 
ON CA.idCarro = L.fk_idCarro;

-- 8 Liste o modelo do carro, a cor e o nome do cliente que fez a locação no dia 10/02/2023.
USE newtonloc;
SELECT CA.modelo, CA.cor, C.nome FROM carros CA 
INNER JOIN locacao L 
ON CA.idCarro = L.fk_idCarro 
INNER JOIN clientes C 
ON C.idCliente = L.fk_idCliente
WHERE L.dataLocacao = '2023-02-10';

-- 9 Mostre a categoria e o modelo dos carros que foram locados juntamente com os nomes dos clientes.
USE newtonloc;
SELECT CA.categoria, CA.modelo, C.nome FROM carros CA
INNER JOIN locacao L
ON CA.idCarro = L.fk_idCarro
INNER JOIN clientes C 
ON C.idCliente = L.fk_idCliente;

-- 10 Liste os dados de todos os carros alugados (fabricante, modelo, categoria) junto com o nome do cliente e a data da locação.
USE newtonloc;
SELECT CA.fabricante, CA.categoria, CA.modelo, C.nome, L.dataLocacao FROM carros CA
INNER JOIN locacao L
ON CA.idCarro = L.fk_idCarro
INNER JOIN clientes C 
ON C.idCliente = L.fk_idCliente;

-- 11 Liste o nome e CPF dos clientes que alugaram carros da categoria "SUV".
USE newtonloc;
SELECT C.nome, C.cpf FROM clientes C 
INNER JOIN locacao L
ON C.idCliente = L.fk_idCliente
INNER JOIN carros CA 
ON CA.idCarro = L.fk_idCarro
WHERE CA.categoria = 'SUV'; 

-- 12 Mostre o nome dos clientes, seus emails e os modelos dos carros alugados.
USE newtonloc;
SELECT C.nome, C.email, CA.modelo FROM clientes C 
INNER JOIN locacao L 
ON C.idCliente = L.fk_idCliente
INNER JOIN carros CA 
ON CA.idCarro = L.fk_idCarro
ORDER BY C.nome ASC;

-- 13 Exiba o nome dos clientes que já alugaram carros com comprimento maior que 4 metros.
USE newtonloc;
SELECT C.nome FROM clientes C 
INNER JOIN locacao L 
ON C.idCliente = L.fk_idCliente
INNER JOIN carros CA 
ON CA.idCarro = L.fk_idCarro
INNER JOIN dimensoes D
ON CA.idCarro = D.fk_idCarro
WHERE D.comprimento_mm > 4
GROUP BY C.nome; 

-- 14 Liste o nome dos clientes que alugaram carros com potência superior a 1.8, mostrando também o modelo do carro.
USE newtonloc;
SELECT C.nome, CA.modelo FROM clientes C 
INNER JOIN locacao L 
ON C.idCliente = L.fk_idCliente
INNER JOIN carros CA 
ON CA.idCarro = L.fk_idCarro
WHERE CA.potenciaMotor > 1.8;

-- 15 Mostre os dados completos dos clientes que fizeram locações, incluindo o valor da diária e o modelo do carro.
USE newtonloc;
SELECT C.*, L.valorDiaria, CA.modelo FROM clientes C 
INNER JOIN locacao L 
ON C.idCliente = L.fk_idCliente
INNER JOIN carros CA 
ON CA.idCarro = L.fk_idCarro;

-- 16 Liste o nome dos clientes e a quantidade de locações que eles já fizeram. Mostre também os clientes que nunca alugaram.
USE newtonloc;
SELECT C.nome, COUNT(L.idLocacao) FROM clientes C 
LEFT JOIN locacao L 
ON C.idCliente = L.fk_idCliente
GROUP BY C.nome;

-- 17 Mostre os modelos de carros e o número de vezes que cada um foi alugado, incluindo os carros que nunca foram alugados.
USE newtonloc;
SELECT CA.modelo, COUNT(L.idLocacao) FROM carros CA 
LEFT JOIN locacao L 
ON CA.idCarro = L.fk_idCarro
GROUP BY CA.modelo;

-- 18 Exiba todos os clientes e, caso tenham alugado carros, mostre a cor do último carro alugado.
USE newtonloc;
SELECT C.nome, CA.cor FROM clientes C 
LEFT JOIN locacao L 
ON C.idCliente = L.fk_idCliente
AND L.dataLocacao = (SELECT MAX(L2.dataLocacao) FROM locacao L2
						INNER JOIN clientes C 
                        ON C.idCliente = L2.fk_idCliente
						WHERE C.idCliente = L.fk_idCliente) 
LEFT JOIN carros CA 
ON CA.idCarro = L.fk_idCarro;

-- 19 Qual o total de quilometragem dos carros que já foram alugados?
USE newtonloc;
SELECT SUM(CA.quilometragem) AS 'Soma de Quilometros - Carros Alugados' FROM carros CA 
INNER JOIN locacao L 
ON CA.idCarro = L.fk_idCarro;

-- 20 Qual o total de valores pagos por locações (valor da diária) por cliente?
USE newtonloc;
SELECT SUM(L.valorDiaria) AS 'Soma total de todas as locações', C.nome FROM locacao L 
INNER JOIN clientes C 
ON C.idCliente = L.fk_idCliente
GROUP BY C.nome;

-- Questão 10
-- Esqueleto para criar uma procedure 
/* USE newtonloc;
DROP PROCEDURE IF EXISTS ;
DELIMITER $$
CREATE PROCEDURE ()
BEGIN

END $$
DELIMITER ;
CALL ();*/

-- 1- Inserir novo cliente
DROP PROCEDURE IF EXISTS sp_inserirCliente;
DELIMITER $$
CREATE PROCEDURE sp_inserirCliente(IN nome1 VARCHAR(45), IN cpf1 CHAR(11), IN telefone1 CHAR(11), IN email1 VARCHAR(45), IN tipo1 VARCHAR(45))
BEGIN
INSERT INTO newtonloc.clientes (nome, cpf, telefone, email, pontuacao, tipo) 
VALUES (nome1, cpf1, telefone1, email1, 0, tipo1);
END $$
DELIMITER ;
CALL sp_inserirCliente('Lucas', '12755565415', '3199999999', 'lucas@newton.com.br', 'Basico');

-- 2 - Atualizar quilometragem de um carro depois de alugado
DROP PROCEDURE IF EXISTS sp_atualizarQuilometragem;
DELIMITER $$
CREATE PROCEDURE sp_atualizarQuilometragem(IN val_quilometragem BIGINT, IN modeloAlugado VARCHAR(45))
BEGIN
UPDATE newtonloc.carros 
SET 
	quilometragem = val_quilometragem
WHERE 
	modelo = modeloAlugado;
END $$
DELIMITER ;
CALL sp_atualizarQuilometragem(450,'hb20');

-- 3 - Listar locações (data e modelo do carro) por cliente ao passar um Id específico 
USE newtonloc;
DROP PROCEDURE IF EXISTS sp_listarLocacoes;
DELIMITER $$
CREATE PROCEDURE sp_listarLocacoes(IN idInserido INT, OUT modelo VARCHAR(45), OUT dataLocacao DATE)
BEGIN
SELECT CA.modelo, L.dataLocacao FROM carros CA 
INNER JOIN locacao L 
ON CA.idCarro = L.fk_idCarro
WHERE L.fk_idCliente = idInserido;
END $$
DELIMITER ;
CALL sp_listarLocacoes(2, @modeloLocado, @dataDeLocacao);

-- 4 - Calcular total de receitas de locações
USE newtonloc;
DROP PROCEDURE IF EXISTS sp_calcularReceita;
DELIMITER $$
CREATE PROCEDURE sp_calcularReceita(OUT somaValorDiaria DOUBLE)
BEGIN
SELECT SUM(valorDiaria) INTO somaValorDiaria FROM locacao;
END $$
DELIMITER ;
CALL sp_calcularReceita(@receita);
SELECT @receita AS 'Receita Total';

-- 5 - Atualizar pontuação de um cliente a partir do id inserido e retornar o o nome e a pontuacao do cliente.
USE newtonloc;
DROP PROCEDURE IF EXISTS sp_atualizaPontuacao;
DELIMITER $$
CREATE PROCEDURE sp_atualizaPontuacao(IN idInserido INT, IN potuacaoInserida INT, OUT pontuacaoAtualizada INT)
BEGIN
UPDATE clientes C
SET C.pontuacao = C.pontuacao + potuacaoInserida
WHERE C.idCliente = idInserido;
    
SELECT C.pontuacao INTO pontuacaoAtualizada
FROM clientes C
WHERE C.idCliente = idInserido;
END $$
DELIMITER ;
CALL sp_atualizaPontuacao(1, 1000, @pontuacaoAtualizada);
SELECT @pontuacaoAtualizada;

-- 6 - Exibir todos os id de locações e os nomes de clientes dentro de um período ao receber a data de início e fim desejada
USE newtonloc;
DROP PROCEDURE IF EXISTS sp_locacaoPorPeriodo;
DELIMITER $$
CREATE PROCEDURE sp_locacaoPorPeriodo(IN dataInicio DATE, IN dataFim DATE)
BEGIN
SELECT L.idLocacao, C.nome FROM locacao L 
INNER JOIN clientes C 
ON C.idCliente = L.fk_idCliente
WHERE L.dataLocacao BETWEEN dataInicio AND dataFim; 
END $$
DELIMITER ;
CALL sp_locacaoPorPeriodo('2023-01-01', '2023-01-31');

-- 7 - Exibir a quantidade total de locações e a quantidade de clientes que locaram dentro de um período ao receber a data de início e fim desejada
USE newtonloc;
DROP PROCEDURE IF EXISTS sp_totalLocacaoPorPeriodo;
DELIMITER $$
CREATE PROCEDURE sp_totalLocacaoPorPeriodo(IN dataInicio DATE, IN dataFim DATE, OUT TotalLocacaoPeriodo INT, OUT quantidadeCliente INT)
BEGIN
SELECT COUNT(L.idLocacao) INTO TotalLocacaoPeriodo
FROM locacao L
WHERE L.dataLocacao >= dataInicio AND L.dataLocacao <= dataFim;

SELECT COUNT(DISTINCT L.fk_idCliente) INTO quantidadeCliente
FROM locacao L 
WHERE L.dataLocacao >= dataInicio AND L.dataLocacao <= dataFim;
END $$
DELIMITER ;
CALL sp_totalLocacaoPorPeriodo('2023-01-01', '2023-01-31', @TotalLocacaoPeriodo, @quantidadeCliente);
SELECT @TotalLocacaoPeriodo, @quantidadeCliente;

-- 8 - Atualizar o telefone de um cliente a partir de um Id inserido e o novo dado telefônico
USE newtonloc;
DROP PROCEDURE IF EXISTS sp_atualizarTelefone;
DELIMITER $$
CREATE PROCEDURE sp_atualizarTelefone(IN idClienteInserido INT, IN telefoneInserido char(11))
BEGIN
UPDATE clientes
SET telefone = telefoneInserido
WHERE idCliente = idClienteInserido;
END $$
DELIMITER ;

SELECT * FROM clientes; -- Teste antes e após a chamada da procedure 
CALL sp_atualizarTelefone(7, '31987594202');
SELECT * FROM clientes;

-- 9 - Listar o modelo de carro que mais foi alugado.
USE newtonloc;
DROP PROCEDURE IF EXISTS sp_carroMaisAlugado;
DELIMITER $$
CREATE PROCEDURE sp_carroMaisAlugado(OUT modeloMaisAlugado varchar(45))
BEGIN
SELECT CA.modelo INTO modeloMaisAlugado 
FROM carros CA 
INNER JOIN locacao L 
ON CA.idCarro = L.fk_idCarro
GROUP BY CA.modelo -- Agrupa pela sequencia de modelos
ORDER BY COUNT(L.idLocacao) DESC -- Ordena pela contagem de locações dos modelos do mais alguda pro menos
LIMIT 1; -- Restringe a visão somente para 1 linha, neste caso a primeira
END $$
DELIMITER ;
CALL sp_carroMaisAlugado(@modeloMaisAlugado);
SELECT @modeloMaisAlugado AS 'Modelo de Carro mais alugado';

-- 10 - Cliente que mais alugou carros em um determinado período
USE newtonloc;
DROP PROCEDURE IF EXISTS sp_clienteDoAno;
DELIMITER $$
CREATE PROCEDURE sp_clienteDoAno(IN dataInicio DATE, IN dataFim DATE, OUT clienteDoAno VARCHAR(45))
BEGIN
SELECT C.nome INTO clienteDoAno
FROM clientes C 
INNER JOIN locacao L 
ON C.idCliente = L.fk_idCliente
WHERE L.dataLocacao BETWEEN dataInicio AND dataFim
GROUP BY C.nome 
ORDER BY COUNT(L.idLocacao) DESC 
LIMIT 1;
END $$
DELIMITER ;
CALL sp_clienteDoAno('2023-01-01', '2023-12-31', @clienteDoAno); -- Período de 1 ano
SELECT @clienteDoAno AS 'Cliente do Mês';
