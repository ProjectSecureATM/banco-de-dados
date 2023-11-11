drop database secureatm;
create database SecureATM;

use SecureATM;

CREATE TABLE plano (
    idPlano INT AUTO_INCREMENT PRIMARY KEY,
    tipo INT,
    nome VARCHAR(45)
);

insert into plano values
(null, 1, 'standart'),
(null, 2, 'advanced');

CREATE TABLE empresa (
    idEmp INT AUTO_INCREMENT PRIMARY KEY,
    CNPJ CHAR(14),
    nome VARCHAR(45),
    razao_social VARCHAR(45),
    codigoEmpresa INT,
    fkPlano INT,
    FOREIGN KEY (fkPlano) REFERENCES plano(idPlano)
);

insert into empresa values
(null, 012012012012, 'bradesco', 'Roberto Silva', 0121, 2),
(null, 012012012012, 'santander', 'Roberto nogueira', 0212, 2);

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
(null, 123-0, 1),
(null, 123-1, 2);

insert into codigoAgencia values
(null, 0121, 1),
(null, 0242, 1);

CREATE TABLE nivelAcesso (
idNivelAcesso INT PRIMARY KEY AUTO_INCREMENT,
tipo INT,
cargo varchar(30)
);

insert into nivelAcesso values
(null, 2, 'RepresentanteLegal'),
(null, 1, 'EngenheiroDeNoc'),
(null, 3, 'UsuarioComum');

CREATE TABLE usuario (
    idFunc INT AUTO_INCREMENT,
    email VARCHAR(45),
    senha VARCHAR(45),
    nome VARCHAR(45),
    fkAgencia INT, 
    fkNivelAcesso INT,
    FOREIGN KEY (fkNivelAcesso) REFERENCES nivelAcesso(idNivelAcesso),
    FOREIGN KEY (fkagencia) REFERENCES agencia(idAgen),
    CONSTRAINT pkFuncAgen PRIMARY KEY (idFunc, fkAgencia)
);

INSERT INTO usuario(email, senha, nome, fkAgencia, fkNivelAcesso) VALUES
('giovanna@sptech.school', 'teste321', 'Giovanna Freitas', 1, 2);

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

CREATE TABLE ATM (
    idATM INT AUTO_INCREMENT,
    Modelo VARCHAR(45),
    Fabricante VARCHAR(45),
    AgenciaID INT,
    fkAgenciaEmpresa INT,
    FOREIGN KEY (AgenciaID) REFERENCES agencia(idAgen),
    FOREIGN KEY (fkAgenciaEmpresa) REFERENCES Agencia(idAgen),
	CONSTRAINT pkATMAgen PRIMARY KEY (idATM, AgenciaID, fkAgenciaEmpresa)
     #CONSTRAINT pkAgenEmpATM PRIMARY KEY (idATM, fkAgenciaEmpresa)
);

INSERT INTO ATM VALUES
(null," Diebold Nixdorf 280", "Diebold Nixdorf", 1,1);

CREATE TABLE Processos (
id INT AUTO_INCREMENT,
PID INT,
nome varchar(45),
fkATM INT,
FOREIGN KEY (fkATM) REFERENCES ATM(idATM),
     CONSTRAINT pkATMAPro PRIMARY KEY (id, fkATM)
);

CREATE TABLE CodigoComponentes (
    idCodComponentes INT AUTO_INCREMENT PRIMARY KEY,
    Componente VARCHAR(45)
);
INSERT INTO CodigoComponentes VALUES 
(null, "RAM"),
(null, "Disco"),
(null, "CPU");

CREATE TABLE Tipo (
    idTipo INT AUTO_INCREMENT PRIMARY KEY,
    UnidadeMedida varchar(2)
);

INSERT INTO Tipo VALUES
(null, 'GB' ),
(null, 'Mb' );

CREATE TABLE Componentes (
    id INT AUTO_INCREMENT,
    quantidade INT,
    CodigoComponenteID INT,
    ATMID INT,
    TipoID INT,
    FOREIGN KEY (CodigoComponenteID) REFERENCES CodigoComponentes(idCodComponentes),
    FOREIGN KEY (ATMID) REFERENCES ATM(idATM),
    FOREIGN KEY (TipoID) REFERENCES Tipo(idTipo),
    CONSTRAINT  pkCompATM PRIMARY KEY (id, ATMID)
);

INSERT INTO Componentes VALUES
(null, 5, 1 , 1, 1),
(null, 10, 2 , 1, 1),
(null, 4, 3 , 1, 1);

CREATE TABLE Leitura (
    LeituraID INT AUTO_INCREMENT,
    DataRegistro DATETIME,
    Valor FLOAT,
    Componente_ID INT,
    ATMComp_ID INT,
    FOREIGN KEY (Componente_ID) REFERENCES Componentes(id),
    FOREIGN KEY (ATMComp_ID) REFERENCES ATM(idATM),
	CONSTRAINT pkLeiCom PRIMARY KEY (LeituraID, Componente_ID, ATMComp_ID)
     #CONSTRAINT pkLeiATMComp PRIMARY KEY (LeituraID, ATMComp_ID)
);

CREATE TABLE Escalonamento (
    Escalonamento_ID INT PRIMARY KEY AUTO_INCREMENT,
    TipoEmergencia VARCHAR(45)
);

insert into Escalonamento values
(null, 'Emergência'),
(null, 'Médio'),
(null, 'Sussa');



CREATE TABLE Aviso (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Leitura_ID INT,
    DataHora DATETIME,
    Escalonamento_ID INT,
    FOREIGN KEY (Leitura_ID) REFERENCES Leitura(LeituraID),
    FOREIGN KEY (Escalonamento_ID) REFERENCES Escalonamento(Escalonamento_ID)
    
);

CREATE TABLE relatarProblema (
idRelatarProblema INT PRIMARY KEY AUTO_INCREMENT,
nome varchar(45),
sobrenome varchar(45),
email varchar(50),
tituloProblema varchar(45),
descricao varchar(100),
dataHoraProblema datetime 
);

select*from agencia;
select*from atm;
select*from aviso;
select*from codigoagencia;
select*from codigocomponentes;
select*from componentes;
select*from empresa;
select*from escalonamento;
select*from usuario;
select*from leitura;
select*from localizacao;
select*from plano;
select*from processos;
select*from tipo;
select*from relatarProblema;
