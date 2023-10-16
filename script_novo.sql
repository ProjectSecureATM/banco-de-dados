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
    idAgen INT AUTO_INCREMENT PRIMARY KEY,
    nAgencia VARCHAR(10),
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmp)
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
    idFunc INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(45),
    senha VARCHAR(45),
    nome VARCHAR(45),
    fkAgencia INT, 
    FOREIGN KEY (fkagencia) REFERENCES agencia(idAgen)
);

CREATE TABLE representante_legal (
    RepresentanteLegal INT AUTO_INCREMENT PRIMARY KEY,
    Empresa_idFuncionario INT,
    Funcionario_FKAgencFunc INT,
    email varchar(45),
    senha char(8),
    FOREIGN KEY (Empresa_idFuncionario) REFERENCES empresa(idEmp),
    FOREIGN KEY (Funcionario_FKAgencFunc) REFERENCES funcionario(idFunc)
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
    idATM INT AUTO_INCREMENT PRIMARY KEY,
    Modelo VARCHAR(45),
    Fabricante VARCHAR(45),
    AgenciaID INT,
    FOREIGN KEY (AgenciaID) REFERENCES agencia(idAgen)
);

CREATE TABLE CodigoComponentes (
    idCodComponentes INT AUTO_INCREMENT PRIMARY KEY,
    Componente VARCHAR(45)
);

CREATE TABLE Tipo (
    idTipo INT AUTO_INCREMENT PRIMARY KEY,
    UnidadeMedida INT
);

CREATE TABLE Componentes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Capacidade INT,
    Descricao VARCHAR(45),
    CodigoComponenteID INT,
    ATMID INT,
    TipoID INT,
    FOREIGN KEY (CodigoComponenteID) REFERENCES CodigoComponentes(idCodComponentes),
    FOREIGN KEY (ATMID) REFERENCES ATM(idATM),
    FOREIGN KEY (TipoID) REFERENCES Tipo(idTipo)
);

CREATE TABLE Processos (
id INT PRIMARY KEY AUTO_INCREMENT,
PID INT,
nome varchar(45)
);

CREATE TABLE Leitura (
    LeituraID INT PRIMARY KEY,
    DataRegistro DATETIME,
    Valor FLOAT,
    Componente_ID INT,
    ATM_ID INT,
    FOREIGN KEY (Componente_ID) REFERENCES Componentes(id),
    FOREIGN KEY (ATM_ID) REFERENCES ATM(idATM)
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
    FOREIGN KEY (Leitura_ID) REFERENCES Leitura(Leitura_ID),
    FOREIGN KEY (Escalonamento_ID) REFERENCES Escalonamento(Escalonamento_ID)
    
);




