create database triggers;
show databases;
use triggers;


CREATE TABLE produtos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  data_validade DATE NOT NULL,
  preco DECIMAL(10, 2) NOT NULL
);
INSERT INTO produtos (nome, data_validade, preco) VALUES
('Produto 1', '2023-12-31', 50.00),
('Produto 2', '2023-11-30', 75.00),
('Produto 3', '2023-10-15', 120.00);

DELIMITER //

CREATE TRIGGER tg_validar_data_validade
BEFORE INSERT ON produtos
FOR EACH ROW
BEGIN
    IF NEW.data_validade < CURDATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Data de validade vencida';
    END IF;
END //
DELIMITER ;

DELIMITER //

CREATE TRIGGER tg_aumentar_preco
BEFORE UPDATE ON produtos
FOR EACH ROW
BEGIN
    SET NEW.preco = NEW.preco * 1.1;
END //

DELIMITER ;
DELIMITER //

CREATE TRIGGER tg_atualizar_estoque
AFTER INSERT ON vendas
FOR EACH ROW
BEGIN
    UPDATE produtos
    SET quantidade_em_estoque = quantidade_em_estoque - 1
    WHERE id = NEW.produto_id;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER tg_registrar_demissao
AFTER DELETE ON tb_funcionarios
FOR EACH ROW
BEGIN
    INSERT INTO tb_funcionarios_demitidos (id, nome, email, data_nascimento)
    VALUES (OLD.id, OLD.nome, OLD.email, OLD.data_nascimento);
END //

DELIMITER ;

