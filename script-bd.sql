CREATE DATABASE SecureATM;
DROP DATABASE SecureATM;
use SecureATM;

CREATE TABLE empresa (
id_empresa INT PRIMARY KEY AUTO_INCREMENT,
razao_social VARCHAR(45),
cnpj VARCHAR(45),
senha VARCHAR(45),
email VARCHAR(45)); 

INSERT INTO empresa VALUES (NULL, "Bradesco", "34.223.147/0001-62", "bradesco123", 'bradesco@hotmail.com');

CREATE TABLE associado (
id_associado INT AUTO_INCREMENT,
email VARCHAR(45),
fk_empresa INT,
 CONSTRAINT fk_emp_associado FOREIGN KEY (fk_empresa)
  REFERENCES empresa (id_empresa),
   PRIMARY KEY (id_associado, fk_empresa)
);

INSERT INTO associado VALUES (null, 'gabriel.bradesco@hotmail.com',1);

CREATE TABLE funcionario (
id_funcionario INT AUTO_INCREMENT,
nome VARCHAR(45),
email VARCHAR(45),
senha VARCHAR(64),
fk_empresa INT,
 CONSTRAINT fk_emp_funcionario FOREIGN KEY (fk_empresa)
  REFERENCES empresa (id_empresa),
   PRIMARY KEY (id_funcionario, fk_empresa));
   
INSERT INTO funcionario VALUES (NULL, "Gabriel", "gabriel.bradesco@hotmail.com", "123456", 1);

/* SELECT PARA VERIFICAR SE O EMAIL QUE O FUNCIONARIO CADASTROU ESTA ASSOCIADO A ALGUMA EMPRESA */
SELECT * FROM associado WHERE email = 'gabriel.bradesco@hotmail.com';

CREATE TABLE atm(
id_atm INT AUTO_INCREMENT,
modelo VARCHAR(45),
fabricante VARCHAR(45),
so VARCHAR(45),
processador VARCHAR(45),
ram VARCHAR(45),
qtd_disco VARCHAR(45),
fk_empresa INT,
 CONSTRAINT fk_emp_atm FOREIGN KEY (fk_empresa)
  REFERENCES empresa (id_empresa),
   PRIMARY KEY (id_atm, fk_empresa));
   
INSERT INTO atm VALUES (NULL, "NCR Corporation", "NCR SelfServ", "Windows", "Intel Core i3", "4 GB", "128 GB SSD", 1);

SELECT * FROM atm;

CREATE TABLE componente(
id_componente INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45)
);

INSERT INTO componente VALUES(NULL, "cpu");
INSERT INTO componente VALUES(NULL, "memoria");
INSERT INTO componente VALUES(NULL, "disco");
INSERT INTO componente VALUES(NULL, "rede");

SELECT * FROM componente;

CREATE TABLE atributo(
id_atributo INT AUTO_INCREMENT,
nome VARCHAR(45),
tipo_dado VARCHAR(45),
unidade VARCHAR(45),
fk_componente INT,
 CONSTRAINT fk_componente_atributo FOREIGN KEY (fk_componente)
  REFERENCES componente (id_componente),
  PRIMARY KEY(id_atributo, fk_componente)
);

/* INSERINDO ATRIBUTOS DA CPU*/
INSERT INTO atributo VALUES (NULL, "porcentagem_utilizada", "Float", "%", 1);
INSERT INTO atributo VALUES (NULL, "velocidade", "porcentagem", "GHz", 1);

/* INSERINDO ATRIBUTOS DA MEMÓRIA*/
INSERT INTO atributo VALUES (NULL, "capacidade_total", "INT", "GB", 2);

SELECT * FROM atributo;
SELECT * FROM atributo JOIN componente ON fk_componente = id_componente;

CREATE TABLE leitura(
id_leitura INT PRIMARY KEY AUTO_INCREMENT,
data_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
valor VARCHAR(45),
fk_atm INT,
 CONSTRAINT fk_leitura_atm FOREIGN KEY (fk_atm)
  REFERENCES atm (id_atm),
fk_empresa INT,
 CONSTRAINT fk_leitura_empresa FOREIGN KEY (fk_empresa)
  REFERENCES empresa (id_empresa),
  fk_atributo INT,
 CONSTRAINT fk_leitura_atributo FOREIGN KEY (fk_atributo)
  REFERENCES atributo (id_atributo)
  );
  
  INSERT INTO leitura (id_leitura, valor, fk_atm, fk_empresa, fk_atributo, fk_componente) VALUES(NULL, "22.5", 1, 1, 1);
  INSERT INTO leitura (id_leitura, valor, fk_atm, fk_empresa, fk_atributo, fk_componente) VALUES(NULL, "0.98", 1, 1, 2);
  
  /* SELECT NA LEITURA COM BASE NO NOME DO COMPONENTE */
  SELECT * from leitura JOIN atributo ON leitura.fk_atributo = atributo.id_atributo
  JOIN componente ON atributo.fk_componente = componente.id_componente
  WHERE componente.nome = "cpu";
  
  /* SELECT NA LEITURA COM BASE NO NOME DO COMPONENTE */
  SELECT leitura.data_registro, leitura.valor, atributo.nome FROM leitura JOIN atributo ON leitura.fk_atributo = atributo.id_atributo 
  JOIN componente ON atributo.fk_componente = componente.id_componente
  WHERE componente.nome = "cpu";
    

   

