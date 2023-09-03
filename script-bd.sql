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

CREATE TABLE cpu(
id_cpu INT PRIMARY KEY AUTO_INCREMENT,
aberto TINYINT,
data_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
porcentagem_utilizacao FLOAT,
velocidade DECIMAL(3,2),
processos INT,
tempo_usuario VARCHAR(45),
tempo_sistema VARCHAR(45),
fk_atm INT,
 CONSTRAINT fk_cpu_atm FOREIGN KEY (fk_atm)
  REFERENCES atm (id_atm),
fk_empresa INT,
 CONSTRAINT fk_cpu_empresa FOREIGN KEY (fk_empresa)
  REFERENCES empresa (id_empresa));
  
INSERT INTO cpu VALUES (NULL, true, CURRENT_TIMESTAMP, 63, 0.89, 292, 420030, 3200000, 1, 1)
;
SELECT * FROM cpu;

CREATE TABLE memoria(
id_memoria INT PRIMARY KEY AUTO_INCREMENT,
aberto TINYINT,
data_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
total FLOAT,
usado FLOAT,
livre INT,
porcentagem_uso FLOAT,
fk_atm INT,
 CONSTRAINT fk_memoria_atm FOREIGN KEY (fk_atm)
  REFERENCES atm (id_atm),
fk_empresa INT,
 CONSTRAINT fk_memoria_empresa FOREIGN KEY (fk_empresa)
  REFERENCES empresa (id_empresa));

INSERT INTO memoria VALUES (NULL, TRUE, CURRENT_TIMESTAMP, 7.91, 5.91, 1.94, 75.5, 1, 1);
  SELECT * FROM memoria;
  
  CREATE TABLE disco (
    idDisco INT PRIMARY KEY AUTO_INCREMENT,
    aberto TINYINT,
    data_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    nome_disco VARCHAR(45),
    sistema_de_arquivo VARCHAR(45),
    porcentagem_uso FLOAT,
    capacidade_total BIGINT,
    capacidade_usada BIGINT,
    capacidade_livre BIGINT,
    leituras INT,
    escritas INT,
    fk_atm INT,
    fk_empresa INT,
    CONSTRAINT fk_disco_atm FOREIGN KEY (fk_atm) REFERENCES atm (id_atm),
    CONSTRAINT fk_disco_empresa FOREIGN KEY (fk_empresa) REFERENCES empresa (id_empresa)
);

INSERT INTO disco VALUES (NULL, TRUE, CURRENT_TIMESTAMP, "C:" , "NTFS", 20.2, 46361795, 9361490, 37000299,4264314, 4680650, 1, 1);
SELECT * FROM disco;
  
  CREATE TABLE rede (
  id_rede INT PRIMARY KEY AUTO_INCREMENT,
  aberto TINYINT,
  data_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  nome_host VARCHAR(255),
  endereco_ip VARCHAR(45) ,
  tipo_conexao VARCHAR(45) ,
  velocidade_conexao INT,
  bytes_enviados BIGINT,
  bytes_recebidos BIGINT,
  latencia_ms INT,
 fk_atm INT,
    fk_empresa INT,
    CONSTRAINT fk_rede_atm FOREIGN KEY (fk_atm) REFERENCES atm (id_atm),
    CONSTRAINT fk_rede_empresa FOREIGN KEY (fk_empresa) REFERENCES empresa (id_empresa));
    
    INSERT INTO rede VALUES (NULL, TRUE,CURRENT_TIMESTAMP, "Joao","192.168.1.1", "Ethernet", 1000, 1234567, 9876543, 4, 1, 1);
	SELECT * FROM rede;
  

   

