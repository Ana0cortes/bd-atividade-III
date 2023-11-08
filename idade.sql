create database idade;
show databases;
use idade;

CREATE TABLE tb_clientes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  idade INT NOT NULL
);

INSERT INTO tb_clientes (nome, idade) VALUES
('João', 25),
('Maria', 30),
('José', 45);

CREATE TABLE clientes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  idade INT NOT NULL
);


CREATE TABLE funcionarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  cargo VARCHAR(255),
  departamento VARCHAR(255)

);


CREATE TABLE produtos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  produto VARCHAR(255) NOT NULL,
  quantidade_em_estoque INT
);


CREATE TABLE vendas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT,
  FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);


CREATE TABLE pedidos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  numero_pedido VARCHAR(50) NOT NULL,
  cliente VARCHAR(255),
  status VARCHAR(50),
  data_entrega DATE
);

CREATE VIEW _clientes_maiores_idade AS
SELECT id, nome, idade
FROM tb_clientes    
WHERE idade >= 18;
CREATE VIEW vw_funcionarios_departamento AS
SELECT nome, cargo
FROM funcionarios
WHERE departamento = 'Administrativo';

CREATE VIEW vw_estoque_insuficiente AS
SELECT produto, quantidade_em_estoque
FROM produtos
WHERE quantidade_em_estoque < 5;

CREATE VIEW vw_relacionamento_cliente_vendedor AS
SELECT c.nome AS cliente, nome AS vendedor
FROM clientes c
INNER JOIN vendas v ON c.id = v.cliente_id;

CREATE VIEW vw_pedidos_pendentes AS
SELECT numero_pedido, cliente, status
FROM pedidos
WHERE status = 'Pendente' AND data_entrega IS NULL;


SELECT * FROM vw_clientes_maiores_idade;