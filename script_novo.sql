-- Dropando o banco de dados se existir
DROP DATABASE SecureATM;

-- Criando o banco de dados
CREATE DATABASE SecureATM;

-- Utilizando o banco de dados criado
USE SecureATM;

-- Criando a tabela plano
CREATE TABLE plano (
    idPlano INT AUTO_INCREMENT PRIMARY KEY,
    tipo INT,
    nome VARCHAR(45)
);

-- Inserindo dados na tabela plano
INSERT INTO plano VALUES
(null, 1, 'standart'),
(null, 2, 'advanced');

-- Criando a tabela empresa
CREATE TABLE empresa (
    idEmp INT AUTO_INCREMENT PRIMARY KEY,
    CNPJ CHAR(14),
    nome VARCHAR(45),
    razao_social VARCHAR(45),
    codigoEmpresa INT,
    fkPlano INT,
    FOREIGN KEY (fkPlano) REFERENCES plano(idPlano)
);

-- Inserindo dados na tabela empresa
INSERT INTO empresa VALUES
(null, 012012012012, 'bradesco', 'Roberto Silva', 0121, 2),
(null, 012012012012, 'santander', 'Roberto nogueira', 0212, 2);

-- Criando a tabela agencia
CREATE TABLE agencia (
    idAgen INT AUTO_INCREMENT,
    nAgencia VARCHAR(10),
    fkEmpresa INT,
    PRIMARY KEY (idAgen),
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmp)
);

INSERT INTO agencia values
(null, 121-1, 1);

-- Criando a tabela nivelAcesso
CREATE TABLE nivelAcesso (
    idNivelAcesso INT AUTO_INCREMENT PRIMARY KEY,
    tipo INT,
    cargo varchar(30)
);

-- Inserindo dados na tabela nivelAcesso
INSERT INTO nivelAcesso VALUES
(null, 2, 'RepresentanteLegal'),
(null, 1, 'EngenheiroDeNoc'),
(null, 3, 'UsuarioComum');

-- Criando a tabela usuario
CREATE TABLE usuario (
    idUsuario INT AUTO_INCREMENT,
    email VARCHAR(45),
    senha VARCHAR(45),
    nome VARCHAR(45),
    fkAgencia INT,
    fkEmpUsuario INT,
    fkNivelAcesso INT,
    PRIMARY KEY (idUsuario, fkAgencia),
    FOREIGN KEY (fkAgencia) REFERENCES agencia(idAgen),
    FOREIGN KEY (fkEmpUsuario) REFERENCES empresa(idEmp)
);

-- Inserindo dados na tabela usuario
INSERT INTO usuario(email, senha, nome, fkAgencia, fkEmpUsuario, fkNivelAcesso) VALUES
('Bruno.Bradesco@Brad.com', 'Brad@123', 'Bruno', 1, 1, 2);

-- Criando a tabela localizacao
CREATE TABLE localizacao (
    idLoc INT AUTO_INCREMENT PRIMARY KEY,
    cep CHAR(14),
    rua VARCHAR(45),
    numero INT,
    estado CHAR(2),
    pais VARCHAR(45),
    fkAgenciaLoc INT,
    FOREIGN KEY (fkAgenciaLoc) REFERENCES agencia(idAgen)
);

-- Criando a tabela ATM
CREATE TABLE ATM (
    idATM INT AUTO_INCREMENT,
    Modelo VARCHAR(45),
    Fabricante VARCHAR(45),
    AgenciaID INT,
    fkAgenciaEmp INT,
    PRIMARY KEY (idATM),
    FOREIGN KEY (fkAgenciaEmp) REFERENCES Agencia(idAgen)
);

-- Criando a tabela Processos
CREATE TABLE Processos (
    id INT AUTO_INCREMENT,
    PID INT,
    nome varchar(45),
    data_hora DATETIME,
    fkATM INT,
    PRIMARY KEY (id),
    FOREIGN KEY (fkATM) REFERENCES ATM(idATM)
);

-- Criando a tabela CodigoComponentes
CREATE TABLE CodigoComponentes (
    idCodComponentes INT AUTO_INCREMENT PRIMARY KEY,
    Componente VARCHAR(45)
);

-- Inserindo dados na tabela CodigoComponentes
INSERT INTO CodigoComponentes VALUES 
(null, "RAM"),
(null, "Disco"),
(null, "CPU");

-- Criando a tabela Tipo
CREATE TABLE Tipo (
    idTipo INT AUTO_INCREMENT PRIMARY KEY,
    UnidadeMedida varchar(2)
);

-- Inserindo dados na tabela Tipo
INSERT INTO Tipo VALUES
(null, 'GB' ),
(null, 'Mb' );

-- Criando a tabela Componentes
CREATE TABLE Componentes (
    id INT AUTO_INCREMENT,
    quantidade INT,
    CodigoComponenteID INT,
    ATMID INT,
    TipoID INT,
    PRIMARY KEY (id),
    FOREIGN KEY (CodigoComponenteID) REFERENCES CodigoComponentes(idCodComponentes),
    FOREIGN KEY (ATMID) REFERENCES ATM(idATM),
    FOREIGN KEY (TipoID) REFERENCES Tipo(idTipo)
);

-- Criando a tabela Leitura
CREATE TABLE Leitura (
    LeituraID INT AUTO_INCREMENT,
    DataRegistro DATETIME,
    Valor FLOAT,
    Componente_ID INT,
    ATMComp_ID INT,
    PRIMARY KEY (LeituraID),
    FOREIGN KEY (Componente_ID) REFERENCES Componentes(id),
    FOREIGN KEY (ATMComp_ID) REFERENCES ATM(idATM)
);

-- Criando a tabela Escalonamento
CREATE TABLE Escalonamento (
    Escalonamento_ID INT AUTO_INCREMENT PRIMARY KEY,
    TipoEmergencia VARCHAR(45)
);

-- Inserindo dados na tabela Escalonamento
INSERT INTO Escalonamento VALUES
(null, 'Emergência'),
(null, 'Médio'),
(null, 'Em funcionamento');

-- Criando a tabela Aviso
CREATE TABLE Aviso (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Leitura_ID INT,
    DataHora DATETIME,
    Escalonamento_ID INT,
    FOREIGN KEY (Leitura_ID) REFERENCES Leitura(LeituraID),
    FOREIGN KEY (Escalonamento_ID) REFERENCES Escalonamento(Escalonamento_ID)
);

-- Criando a tabela relatarProblema
CREATE TABLE relatarProblema (
    idRelatarProblema INT AUTO_INCREMENT PRIMARY KEY,
    nome varchar(45),
    sobrenome varchar(45),
    email varchar(50),
    tituloProblema varchar(45),
    descricao varchar(100),
    dataHoraProblema datetime 
);


-- Selecione as linhas de cada tabela
SELECT * FROM agencia;
SELECT * FROM localizacao;
SELECT * FROM ATM;
SELECT * FROM aviso;
SELECT * FROM CodigoComponentes;
SELECT * FROM componentes;
SELECT * FROM empresa;
SELECT * FROM escalonamento;
SELECT * FROM usuario;
SELECT * FROM leitura;
SELECT * FROM localizacao;
SELECT * FROM plano;
SELECT * FROM processos;
SELECT * FROM tipo;
SELECT * FROM relatarProblema;
