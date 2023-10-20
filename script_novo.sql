create database SecureATM;

use SecureATM;

CREATE TABLE empresa (
    idEmp INT AUTO_INCREMENT PRIMARY KEY,
    CNPJ CHAR(14),
    nome VARCHAR(45),
    razao_social VARCHAR(45)
);

CREATE TABLE codigoEmpresa (
	idCodEmp INT AUTO_INCREMENT PRIMARY KEY,
    Código INT, 
    fkEmpresaCod INT,
    FOREIGN KEY (fkEmpresaCod) REFERENCES empresa(idEmp)
    );

insert into empresa values
(null, 012012012012, 'bradesco', 'Roberto Silva'),
(null, 012012012012, 'santander', 'Roberto nogueira');

select * from empresa;


CREATE TABLE agencia (
    idAgen INT AUTO_INCREMENT,
    nAgencia VARCHAR(10),
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmp),
    CONSTRAINT pkEmpAgen PRIMARY KEY (idAgen, fkEmpresa) 
);

CREATE TABLE codigoAgencia (
	idCodAgen INT AUTO_INCREMENT PRIMARY KEY,
    Código INT, 
    fkAgenciaCod INT,
    FOREIGN KEY (fkAgenciaCod) REFERENCES agencia(idAgen)
    );

insert into agencia values
(null, 123-0, 1);

CREATE TABLE funcionario (
    idFunc INT AUTO_INCREMENT,
    email VARCHAR(45),
    senha VARCHAR(45),
    nome VARCHAR(45),
    fkAgencia INT, 
    FOREIGN KEY (fkagencia) REFERENCES agencia(idAgen),
    CONSTRAINT pkFuncAgen PRIMARY KEY (idFunc, fkAgencia)
);

CREATE TABLE representante_legal (
    RepresentanteLegal INT AUTO_INCREMENT,
    fkEmpFun INT,
    FKAgencFunc INT,
    email varchar(45),
    senha char(8),
    FOREIGN KEY (fkEmpFunc) REFERENCES empresa(idEmp),
    FOREIGN KEY (FKAgencFunc) REFERENCES funcionario(idFunc),
    CONSTRAINT pkRPLegal PRIMARY KEY (RepresentanteLegal, fkEmpFun, FKAgencFunc)
);

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

CREATE TABLE plano (
    idPlano INT AUTO_INCREMENT PRIMARY KEY,
    tipo INT,
    nome VARCHAR(45),
    fkAgenciaPlan INT,
    FOREIGN KEY (fkAgenciaPlan) REFERENCES agencia(idAgen)
);

CREATE TABLE ATM (
    idATM INT AUTO_INCREMENT,
    Modelo VARCHAR(45),
    Fabricante VARCHAR(45),
    AgenciaID INT,
    fkAgenciaEmpresa INT,
    FOREIGN KEY (AgenciaID) REFERENCES agencia(idAgen),
    FOREIGN KEY (fkAgenciaEmpresa) REFERENCES Agencia(idAgen),
     CONSTRAINT pkATMAgen PRIMARY KEY (idATM, AgenciaID),
     CONSTRAINT pkAgenEmpATM PRIMARY KEY (idATM, fkAgenciaEmpresa)
);

CREATE TABLE Processos (
id INT AUTO_INCREMENT,
PID INT,
nome varchar(45),
fkATM INT,
FOREIGN KEY (fkATM) REFERENCES ATM(idATM),
     CONSTRAINT pkATMAPro PRIMARY KEY (id, idATM)
);

CREATE TABLE CodigoComponentes (
    idCodComponentes INT AUTO_INCREMENT PRIMARY KEY,
    Componente VARCHAR(45)
);
INSERT INTO CodigoComponentes VALUES 
(null, "RAM"),
(null, "Disco"),
(null, "CPU"),
(null, "Latência Rede");

CREATE TABLE Tipo (
    idTipo INT AUTO_INCREMENT PRIMARY KEY,
    UnidadeMedida INT
);

CREATE TABLE Componentes (
    id INT AUTO_INCREMENT,
    Capacidade INT,
    Descricao VARCHAR(45),
    CodigoComponenteID INT,
    ATMID INT,
    TipoID INT,
    FOREIGN KEY (CodigoComponenteID) REFERENCES CodigoComponentes(idCodComponentes),
    FOREIGN KEY (ATMID) REFERENCES ATM(idATM),
    FOREIGN KEY (TipoID) REFERENCES Tipo(idTipo),
    CONSTRAINT  pkCompATM PRIMARY KEY (id, ATMID)
);

CREATE TABLE Leitura (
    LeituraID INT PRIMARY KEY AUTO_INCREMENT,
    DataRegistro DATETIME,
    Valor FLOAT,
    Componente_ID INT,
    ATMComp_ID INT,
    FOREIGN KEY (Componente_ID) REFERENCES Componentes(id),
    FOREIGN KEY (ATM_ID) REFERENCES ATM(idATM),
     CONSTRAINT pkLeiCom PRIMARY KEY (LeituraID, Componente_ID),
     CONSTRAINT pkLeiATMComp PRIMARY KEY (LeituraID, ATMComp_ID)
);

CREATE TABLE Escalonamento (
    Escalonamento_ID INT PRIMARY KEY,
    TipoEmergencia VARCHAR(45)
);

CREATE TABLE Aviso (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Leitura_ID INT,
    DataHora DATETIME,
    Escalonamento_ID INT,
    FOREIGN KEY (Leitura_ID) REFERENCES Leitura(LeituraID),
    FOREIGN KEY (Escalonamento_ID) REFERENCES Escalonamento(Escalonamento_ID)
    
);
