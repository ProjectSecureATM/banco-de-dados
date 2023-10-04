create database SecureATM;

use SecureATM;

CREATE TABLE empresa (
    id INT AUTO_INCREMENT PRIMARY KEY,
    CNPJ CHAR(14),
    nome VARCHAR(45),
    senha VARCHAR(45),
    razao_social VARCHAR(45)
);

CREATE TABLE agencia (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nAgencia VARCHAR(10),
    QtdATM INT,
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(id)
);

CREATE TABLE funcionario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(45),
    senha VARCHAR(45),
    DT_nasc CHAR(10),
    nome VARCHAR(45),
    fkAgencia INT, 
    FOREIGN KEY (fkagencia) REFERENCES agencia(id)
);

CREATE TABLE representante_legal (
    RepresentanteLegal INT AUTO_INCREMENT PRIMARY KEY,
    Empresa_idFuncionario INT,
    Funcionario_FKAgencFunc INT,
    FOREIGN KEY (Empresa_idFuncionario) REFERENCES empresa(id),
    FOREIGN KEY (Funcionario_FKAgencFunc) REFERENCES funcionario(id)
);

CREATE TABLE associado (
    id_associado INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(45),
    fk_empresa INT,
    FOREIGN KEY (fk_empresa) REFERENCES empresa(id)
);

CREATE TABLE localizacao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cep CHAR(14),
    rua VARCHAR(45),
    numero INT,
    estado CHAR(2),
    pais VARCHAR(45),
    fkAgenciaLoc INT,
    FOREIGN KEY (fkAgenciaLoc) REFERENCES agencia(id)
);

CREATE TABLE plano (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo INT,
    nome VARCHAR(45),
    fkAgenciaPlan INT,
    FOREIGN KEY (fkAgenciaPlan) REFERENCES agencia(id)
);

CREATE TABLE atm (
    id INT AUTO_INCREMENT PRIMARY KEY,
    modelo VARCHAR(45),
    so VARCHAR(45),
    processador INT,
    ram INT,
    qtd_discos INT,
    fabricante VARCHAR(45),
    fkAgenciaATM INT,
    FOREIGN KEY (fkAgenciaATM) REFERENCES agencia(id)
);

CREATE TABLE componentes (
    idComponente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45),
    unidade INT,
    descricao VARCHAR(45)
);

CREATE TABLE leitura (
    idLeitura INT AUTO_INCREMENT PRIMARY KEY,
    data_registro DATETIME,
    valor FLOAT,
    fk_atm INT, 
    fk_componente INT, 
    FOREIGN KEY (fk_atm) REFERENCES atm(id), 
    FOREIGN KEY (fk_componente) REFERENCES componentes(idComponente)
);

CREATE TABLE avisos (
    idAvisos INT AUTO_INCREMENT PRIMARY KEY,
    escalonamento INT,
    fkLeitura INT, 
    FOREIGN KEY (fkLeitura) REFERENCES leitura(idLeitura)
);
