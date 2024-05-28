-- -----------------------------------------------------
-- Criando BATABASE `FARMACIA`
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `FARMACIA` DEFAULT CHARACTER SET utf8 ;
USE `FARMACIA`;

-- -----------------------------------------------------
-- Table `FUNCIONARIOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FUNCIONARIOS` (
  `Cod_FUNC` INT PRIMARY KEY NOT NULL,
  `Nome_FUNC` VARCHAR(100) NULL,
  `Sexo_FUNC` CHAR(1) NULL,
  `Email_FUNC` VARCHAR(100) NULL,
  `Turno_FUNC` VARCHAR(45) NULL,
  `Funcao_FUNC` VARCHAR(100) NULL,
  `Salario_FUNC` DECIMAL(6,2) NULL
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `FARMACEUTICOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FARMACEUTICOS` (
  `Cod_FUNC` INT PRIMARY KEY NOT NULL,
  `CRF` INT NOT NULL,
  UNIQUE INDEX `CRF_UNIQUE` (`CRF` ASC) VISIBLE,
  FOREIGN KEY (`Cod_FUNC`) REFERENCES `FUNCIONARIOS` (`Cod_FUNC`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `FABRICANTES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FABRICANTES` (
  `Cod_FAB` INT PRIMARY KEY NOT NULL,
  `Nome_FAB` VARCHAR(45) NULL,
  `Estado_FAB` CHAR(2) NULL
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `PRODUTOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PRODUTOS` (
  `Cod_PROD` INT PRIMARY KEY NOT NULL,
  `Nome_PROD` VARCHAR(45) NULL,
  `Tipo_PROD` VARCHAR(45) NULL,
  `Descricao_PROD` VARCHAR(100) NULL,
  `Valor_PROD` DECIMAL(6,2) NULL,
  `Cod_FAB` INT NOT NULL,
  FOREIGN KEY (`Cod_FAB`) REFERENCES `FABRICANTES` (`Cod_FAB`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `CLIENTES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CLIENTES` (
  `Cod_CLI` INT PRIMARY KEY NOT NULL,
  `Nome_CLI` VARCHAR(45) NOT NULL,
  `Sexo_CLI` CHAR(1) NULL,
  `CPF` VARCHAR(11) NULL,
  `Telefone_CLI` VARCHAR(11) NULL,
  `Endereco_CLI` VARCHAR(100) NULL,
  `Seguro_CLI` VARCHAR(45) NULL
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `MEDICOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MEDICOS` (
  `Cod_MEDICOS` INT PRIMARY KEY NOT NULL,
  `Nome_MEDICOS` VARCHAR(45) NULL,
  `Sexo_MEDICOS` CHAR(2) NULL,
  `CRM` INT NOT NULL,
  `Especialidade_MEDICOS` VARCHAR(45) NULL,
  `Telefone_MEDICOS` VARCHAR(11) NULL,
  UNIQUE INDEX `CRM_UNIQUE` (`CRM` ASC) VISIBLE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `PRESCRICOES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PRESCRICOES` (
  `Cod_PRE` INT PRIMARY KEY NOT NULL,
  `Data_Emissao_PRE` DATETIME NULL,
  `Cod_CLI` INT NOT NULL,
  `Cod_MEDICOS` INT NOT NULL,
  FOREIGN KEY (`Cod_CLI`) REFERENCES `CLIENTES` (`Cod_CLI`),
  FOREIGN KEY (`Cod_MEDICOS`) REFERENCES `MEDICOS` (`Cod_MEDICOS`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `MEDICAMENTOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MEDICAMENTOS` (
  `Cod_PROD` INT PRIMARY KEY NOT NULL,
  `Prin_Ativo_MED` VARCHAR(200) NULL,
  `Dosagem_MED` VARCHAR(45) NULL,
  `Tarja_MED` VARCHAR(45) NULL,
  FOREIGN KEY (`Cod_PROD`) REFERENCES `PRODUTOS` (`Cod_PROD`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `PEDIDOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PEDIDOS` (
  `Cod_PED` INT PRIMARY KEY NOT NULL,
  `Quant_PED` INT NULL,
  `Valor_PED` DECIMAL(6,2) NULL,
  `Cod_PROD` INT NOT NULL,
  `Cod_PRE` INT DEFAULT NULL,
  FOREIGN KEY (`Cod_PROD`) REFERENCES `PRODUTOS` (`Cod_PROD`),
  FOREIGN KEY (`Cod_PRE`) REFERENCES `PRESCRICOES` (`Cod_PRE`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `VENDAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VENDAS` (
  `Cod_VEND` INT PRIMARY KEY NOT NULL,
  `Valor_Total_VEND` DECIMAL(6,2) NULL,
  `Data_VEND` DATETIME NULL,
  `Cod_FUNC` INT NOT NULL,
  `Cod_PED` INT NOT NULL,
  `Cod_CLI` INT DEFAULT NULL,
  FOREIGN KEY (`Cod_FUNC`) REFERENCES `FUNCIONARIOS` (`Cod_FUNC`),
  FOREIGN KEY (`Cod_PED`) REFERENCES `PEDIDOS` (`Cod_PED`),
  FOREIGN KEY (`Cod_CLI`) REFERENCES `CLIENTES` (`Cod_CLI`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `ESTOQUE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ESTOQUE` (
  `Cod_PROD` INT PRIMARY KEY NOT NULL,
  `Quant_EST` INT NOT NULL,
  FOREIGN KEY (`Cod_PROD`) REFERENCES `PRODUTOS` (`Cod_PROD`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Inserindo os dados 
-- -----------------------------------------------------  
LOAD DATA INFILE 'C:/Program Files/MySQL/dados/clientes.csv'
	INTO TABLE `CLIENTES`
    FIELDS TERMINATED BY ';'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES;    
    
LOAD DATA INFILE 'C:/Program Files/MySQL/dados/fabricantes.csv'
	INTO TABLE `FABRICANTES`
    FIELDS TERMINATED BY ';'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES;
 
LOAD DATA INFILE 'C:/Program Files/MySQL/dados/funcionarios.csv'
	INTO TABLE `FUNCIONARIOS`
    FIELDS TERMINATED BY ';'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES;
    
LOAD DATA INFILE 'C:/Program Files/MySQL/dados/medicos.csv'
	INTO TABLE `MEDICOS`
    FIELDS TERMINATED BY ';'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES;

LOAD DATA INFILE 'C:/Program Files/MySQL/dados/produtos.csv'
	INTO TABLE `PRODUTOS`
    FIELDS TERMINATED BY ';'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES;

LOAD DATA INFILE 'C:/Program Files/MySQL/dados/estoque.csv'
	INTO TABLE `ESTOQUE`
    FIELDS TERMINATED BY ';'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES; 
    
LOAD DATA INFILE 'C:/Program Files/MySQL/dados/medicamentos.csv'
	INTO TABLE `MEDICAMENTOS`
    FIELDS TERMINATED BY ';'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES;
    
LOAD DATA INFILE 'C:/Program Files/MySQL/dados/farmaceuticos.csv'
	INTO TABLE `FARMACEUTICOS`
    FIELDS TERMINATED BY ';'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES;
    
LOAD DATA INFILE 'C:/Program Files/MySQL/dados/prescricoes.csv'
	INTO TABLE `PRESCRICOES`
    FIELDS TERMINATED BY ';'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES;
    
LOAD DATA INFILE 'C:/Program Files/MySQL/dados/pedidos.csv'
	INTO TABLE `PEDIDOS`
    FIELDS TERMINATED BY ';'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES;

LOAD DATA INFILE 'C:/Program Files/MySQL/dados/vendas.csv'
	INTO TABLE `VENDAS`
    FIELDS TERMINATED BY ';'
    LINES TERMINATED BY '\n'
    IGNORE 1 LINES;

-- -----------------------------------------------------
-- CONFERINDO TODOS OS DADOS
-- -----------------------------------------------------
SELECT * FROM CLIENTES;
SELECT * FROM FABRICANTES;
SELECT * FROM FUNCIONARIOS;
SELECT * FROM MEDICOS;
SELECT * FROM PRODUTOS;
SELECT * FROM MEDICAMENTOS;
SELECT * FROM FARMACEUTICOS;
SELECT * FROM PRESCRICOES;
SELECT * FROM PEDIDOS;
SELECT * FROM VENDAS;

-- -----------------------------------------------------
-- 30 consultas
-- -----------------------------------------------------

-- 1. Listar todos os farmacêuticos
-- Lista todos os farmacêuticos com seus respectivos CRFs.
SELECT F.Cod_FUNC AS 'Código do Funcionário',
	     F.Nome_FUNC AS 'Nome do Funcionário',
       A.CRF
FROM FUNCIONARIOS F JOIN FARMACEUTICOS A
ON F.Cod_FUNC = A.Cod_FUNC;

-- 2. Listar todos os produtos em estoque e sua quantidade
-- Lista todos os produtos e suas quantidades no estoque.
SELECT P.Nome_PROD AS 'Nome do Produto',
	   E.Quant_EST AS 'Quantidade'
FROM PRODUTOS P JOIN ESTOQUE E
ON P.Cod_PROD = E.Cod_PROD;

-- 3. Listar funcionários que trabalham no turno da noite
-- Lista todos os funcionários que trabalham no turno da noite.
SELECT Nome_FUNC AS 'Nome do Funcionário',
	   Turno_FUNC AS 'Turno'
FROM FUNCIONARIOS
WHERE Turno_FUNC = 'Noturno';

-- 4. Listar médicos por especialidade
-- Lista todos os médicos agrupados por especialidade.
SELECT Especialidade_MEDICOS AS 'Especialidade',
	   COUNT(*) AS 'Nº de Médicos'
FROM MEDICOS
GROUP BY Especialidade_MEDICOS;

-- 5. Listar produtos por fabricante
-- Lista todos os produtos agrupados por fabricante.
SELECT F.Nome_FAB AS 'Nome do Fabricante',
	   COUNT(*) AS 'Nº de Produtos'
FROM FABRICANTES F
JOIN PRODUTOS P ON F.Cod_FAB = P.Cod_FAB
GROUP BY F.Nome_FAB;

-- 6. Listar clientes com seguros de saúde
-- Lista todos os clientes que possuem seguro de saúde.
SELECT Nome_CLI AS 'Nome do Cliente'
FROM CLIENTES
WHERE Seguro_CLI IS NOT NULL;

-- 7. Listar produtos com estoque baixo
-- Lista todos os produtos cujo estoque está abaixo de um valor mínimo.
SELECT P.Nome_PROD AS 'Nome do Produto',
	   E.Quant_EST AS 'Quantidade'
FROM PRODUTOS P JOIN ESTOQUE E
ON P.Cod_PROD = E.Cod_PROD
WHERE E.Quant_EST < 35;

-- 8. Listar clientes que fizeram compras
-- Lista todos os clientes cadastrados que fizeram compras
SELECT C.Nome_CLI AS 'Nome do Cliente',
	   V.Data_VEND AS 'Data da Venda'
FROM CLIENTES C JOIN VENDAS V
ON C.Cod_CLI = V.Cod_CLI
WHERE C.Cod_CLI IS NOT NULL;  

-- 9. Listar o total em vendas realizadas no mês
-- Lista o total (soma dos valores) em vendas realizadas no mês
SELECT DATE_FORMAT(Data_VEND, '%Y-%m') AS 'Mês',
	   SUM(Valor_Total_VEND) AS 'Total Vendido R$'
FROM VENDAS
GROUP BY Mês;

-- 10. Listar o total de produtos vendidos no mês
-- Lista o total de produtos vendidos no mês
SELECT DATE_FORMAT(V.Data_VEND, '%Y-%m') AS 'Mês',
	   SUM(P.Quant_PED) AS 'Total de Produtos Vendidos'
FROM VENDAS V JOIN PEDIDOS P
ON V.Cod_PED = P.Cod_PED
GROUP BY Mês;

-- 11. Listar os medicamentos prescritos em um pedido específico
-- Lista todos os medicamentos prescritos em um pedido.
SELECT P.Nome_PROD AS 'Nome do Produto',
	   Pe.Cod_PED AS 'Código do Pedido'
FROM PRODUTOS P JOIN PEDIDOS Pe
ON P.Cod_PROD = Pe.Cod_PROD
WHERE Pe.Cod_PED = 15; 

-- 12. Listar funcionários com salário acima da média
-- Lista todos os funcionários cujo salário está acima da média.
SELECT Nome_FUNC AS 'Nome do Funcionário',
       Salario_FUNC AS 'Salário do Funcionário R$'
FROM FUNCIONARIOS
WHERE Salario_FUNC > (SELECT AVG(Salario_FUNC) FROM FUNCIONARIOS);

-- 13. Listar clientes que compraram produtos específicos
-- Lista todos os clientes que compraram um determinado produto.
SELECT DISTINCT C.Nome_CLI AS 'Nome do Cliente'
FROM CLIENTES C JOIN VENDAS V
ON C.Cod_CLI = V.Cod_CLI
JOIN PEDIDOS P
ON V.Cod_PED = P.Cod_PED
WHERE P.Cod_PROD = 2 AND C.Cod_CLI IS NOT NULL; 

-- 14. Listar produtos mais pedidos
-- Lista os produtos mais pedidos e suas quantidades.
SELECT P.Nome_PROD AS 'Nome do Produto',
	   SUM(PD.Quant_PED) AS 'Quantidade'
FROM PRODUTOS P JOIN PEDIDOS PD
ON P.Cod_PROD = PD.Cod_PROD
GROUP BY P.Nome_PROD
ORDER BY Quantidade DESC;

-- 15. Listar as prescrições de um cliente específico
-- Lista todas as prescrições emitidas para um determinado cliente cadastrado.
SELECT Cod_PRE
FROM PRESCRICOES
WHERE Cod_CLI = 1;

-- 16. Listar médicos que atenderam um cliente específico
-- Lista todos os médicos que emitiram
-- prescrições para um determinado cliente.
SELECT DISTINCT M.Nome_MEDICOS AS 'Nome do Médico'
FROM MEDICOS M JOIN PRESCRICOES P
ON M.Cod_MEDICOS = P.Cod_MEDICOS
WHERE P.Cod_CLI = 1; 

-- 17. Listar produtos de um determinado fabricante
-- Lista todos os produtos fabricados por um determinado fabricante.
SELECT P.Nome_PROD AS 'Nome do Produto',
	   F.Nome_FAB AS 'Fabricante'
FROM PRODUTOS P JOIN FABRICANTES F
ON F.Cod_FAB = P.Cod_FAB
WHERE P.Cod_FAB = 5; 

-- 18. Listar clientes com prescrições em aberto
-- Lista todos os clientes que possuem prescrições em aberto
-- (sem pedidos associados).
SELECT DISTINCT C.Nome_CLI AS 'Nome do Cliente',
				P.Cod_PRE AS 'Código do Pedido'
FROM CLIENTES C JOIN PRESCRICOES P
ON C.Cod_CLI = P.Cod_CLI
LEFT JOIN PEDIDOS PD
ON P.Cod_PRE = PD.Cod_PRE
WHERE PD.Cod_PRE IS NULL;

-- 19. Listar medicamentos com um determinado princípio ativo
-- Lista todos os medicamentos que contêm um determinado
-- princípio ativo.
SELECT P.Nome_PROD AS 'Medicamento',
	   M.Prin_Ativo_MED AS 'Princípio(s) Ativo(s)'
FROM MEDICAMENTOS M JOIN PRODUTOS P
ON M.Cod_PROD = P.Cod_PROD
WHERE Prin_Ativo_MED LIKE '%paracetamol%';

-- 20. Listar o valor total em vendas realizadas por funcionário
-- Lista o valor total em vendas realizadas por cada funcionário.
SELECT F.Nome_FUNC AS 'Nome do Funcionário',
	   SUM(V.Valor_Total_VEND) AS 'Total Vendido'
FROM FUNCIONARIOS F JOIN VENDAS V
ON F.Cod_FUNC = V.Cod_FUNC
GROUP BY F.Nome_FUNC;

-- 21. Listar vendas realizadas por um funcionário específico
-- Lista todas as vendas realizadas por um determinado funcionário.
SELECT V.Cod_VEND AS 'Código da Venda',
	   F.Nome_FUNC AS 'Funcionário'
FROM VENDAS V JOIN FUNCIONARIOS F
ON V.Cod_FUNC = F.Cod_FUNC
WHERE F.Cod_FUNC = 5;

-- 22. Listar a quantidade total de produtos por tipo
-- Lista a quantidade total de produtos agrupados por tipo de produto.
SELECT Tipo_PROD AS 'Tipo do Produto',
	   COUNT(*) AS 'Quantidade de Produto'
FROM PRODUTOS
GROUP BY Tipo_PROD;

-- 23. Listar a média salarial dos funcionários por função
-- Lista a média salarial dos funcionários agrupados por função.
SELECT Funcao_FUNC AS 'Função',
	   AVG(Salario_FUNC) AS 'Média Salarial'
FROM FUNCIONARIOS
GROUP BY Funcao_FUNC;

-- 24. Listar os medicamentos mais prescritos
-- Lista os medicamentos mais prescritos e suas quantidades.
SELECT P.Nome_PROD AS 'Medicamento',
	   COUNT(*) AS 'Quantidade_Prescricoes'
FROM MEDICAMENTOS MD
JOIN PRODUTOS P ON MD.Cod_PROD = P.Cod_PROD
JOIN PEDIDOS PD ON P.Cod_PROD = PD.Cod_PROD
GROUP BY P.Nome_PROD
ORDER BY Quantidade_Prescricoes DESC;

-- 25. Listar o estoque atual de um produto
-- Lista a quantidade em estoque de um produto específico.
SELECT P.Nome_PROD AS 'Produto',
	   E.Quant_EST AS 'Quantidade'
FROM ESTOQUE E JOIN PRODUTOS P
ON E.Cod_PROD = P.Cod_PROD
WHERE P.Nome_PROD = 'Buscopan'; 

-- 26. Listar a receita total gerada por fabricante
-- Lista a receita total gerada por cada fabricante.
SELECT F.Nome_FAB AS 'Fabricante',
	   SUM(V.Valor_Total_VEND) AS 'Receita Total R$'
FROM FABRICANTES F
JOIN PRODUTOS P ON F.Cod_FAB = P.Cod_FAB
JOIN PEDIDOS PD ON P.Cod_PROD = PD.Cod_PROD
JOIN VENDAS V ON PD.Cod_PED = V.Cod_PED
GROUP BY F.Nome_FAB;

-- 27. Listar prescrições emitidas dentro de um intervalo de datas
-- Lista todas as prescrições emitidas dentro de um intervalo.
SELECT Cod_PRE AS 'Código da Prescrição',
	   Data_Emissao_PRE AS 'Data'
FROM PRESCRICOES
WHERE Data_Emissao_PRE BETWEEN '2024-05-01' AND '2024-05-03'; 

-- 28. Listar clientes com mais de uma prescrição
-- Lista todos os clientes que possuem mais de uma prescrição.
SELECT C.Nome_CLI AS 'Nome do Cliente',
	   COUNT(*) AS 'Quantidade de Prescricoes'
FROM CLIENTES C JOIN PRESCRICOES P
ON C.Cod_CLI = P.Cod_CLI
GROUP BY C.Nome_CLI
HAVING COUNT(*) > 1;

-- 29. Listar os produtos que nunca foram vendidos
-- Lista todos os produtos que nunca foram vendidos, ou seja
-- que não aparecem em nenhuma venda registrada.
SELECT P.Nome_PROD AS 'Produtos não Vendidos'
FROM PRODUTOS P
LEFT JOIN PEDIDOS PD ON P.Cod_PROD = PD.Cod_PROD
LEFT JOIN VENDAS V ON PD.Cod_PED = V.Cod_PED
WHERE V.Cod_VEND IS NULL;

-- 30. Listar os fabricantes com mais produtos
-- Lista os fabricantes que têm a maior quantidade de produtos cadastrados
SELECT F.Nome_FAB AS 'Nome do Fabricante',
	   COUNT(P.Cod_PROD) AS 'Quantidade_Produtos'
FROM FABRICANTES F
JOIN PRODUTOS P ON F.Cod_FAB = P.Cod_FAB
GROUP BY F.Nome_FAB
ORDER BY Quantidade_Produtos DESC;
