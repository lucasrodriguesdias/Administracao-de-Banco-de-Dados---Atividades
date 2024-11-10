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

