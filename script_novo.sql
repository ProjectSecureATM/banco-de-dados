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
    idAgen INT AUTO_INCREMENT PRIMARY KEY,
    nAgencia VARCHAR(10),
    fkEmpresa INT,
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
    idATM INT AUTO_INCREMENT PRIMARY KEY,
    Modelo VARCHAR(45),
    Fabricante VARCHAR(45),
    AgenciaID INT,
    fkAgenciaEmp INT,
    FOREIGN KEY (AgenciaID) REFERENCES Agencia(idAgen),
    FOREIGN KEY (fkAgenciaEmp) REFERENCES Agencia(fkEmpresa)
);

INSERT INTO ATM VALUES 
(null, 'AutoAtendimento', 'Delfors', 1, 1);

INSERT INTO ATM VALUES 
(null, 'AutoAtendimento', 'X', 1, 1);

CREATE TABLE logs(
idLogs INT PRIMARY KEY AUTO_INCREMENT,
data_hora DATETIME,
NCartao char(16),
contaCliente char(8),
fk_idATM INT,
fk_ATMAgencia INT,
fk_AgenciaEmpresa INT,
FOREIGN KEY (fk_idATM) REFERENCES ATM(idATM),
FOREIGN KEY (fk_ATMAgencia) REFERENCES ATM(AgenciaID),
FOREIGN KEY (fk_AgenciaEmpresa) REFERENCES ATM(fkAgenciaEmp)
);

CREATE TABLE mensagem(
idMensagem INT PRIMARY KEY AUTO_INCREMENT,
Mensagem varchar(500),
fkLogs INT,
FOREIGN KEY (fkLogs) REFERENCES logs(idLogs)
); 

CREATE TABLE TipoERRO (
idTipoERRO INT PRIMARY KEY AUTO_INCREMENT,
Tipo varchar(45),
fkMSG INT,
FOREIGN KEY (fkMSG) REFERENCES mensagem(idMensagem)
);

CREATE TABLE rede (
idRede INT PRIMARY KEY AUTO_INCREMENT,
IP varchar(18),
data_hora DATETIME,
Ping INT,
pacotesEnviados INT,
pacotesRecebidos INT,
fk__idATM INT,
fk__ATMAgencia INT,
fk__AgenciaEmpresa INT,
FOREIGN KEY (fk__idATM) REFERENCES ATM(idATM),
FOREIGN KEY (fk__ATMAgencia) REFERENCES ATM(AgenciaID),
FOREIGN KEY (fk__AgenciaEmpresa) REFERENCES ATM(fkAgenciaEmp)
);

CREATE TABLE DDoS (
idDDoS INT PRIMARY KEY AUTO_INCREMENT,
IPAtq char(18),
qtdPacotesAtq INT,
fkRede INT,
FOREIGN KEY (fkRede) REFERENCES Rede(idRede)
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

INSERT INTO processos values 
(null, 50000, 'muitolegal', '2023-11-25 15:01:00', 1 );

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

-- Criando tabela Descrição dos componentes
 CREATE TABLE DescricaoComponentes (
 idDescricaoComponentes INT AUTO_INCREMENT PRIMARY KEY,
 produto VARCHAR(100),
 fabricante VARCHAR(100),
 dataDia date,
 fkComponente INT,
 FOREIGN KEY (fkComponente) REFERENCES CodigoComponentes(idCodComponentes)
 );


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

INSERT INTO Componentes VALUES
(null, 1, 1, 1, 1),
(null, 1, 2, 1, 1),
(null, 1, 3, 1, 1);

CREATE TABLE temperaturaCPU (
idTemp INT AUTO_INCREMENT PRIMARY KEY,
temperatura DOUBLE,
data_hora DATETIME,
fkComp INT,
fkATM INT,
FOREIGN KEY (fkComp) REFERENCES Componentes(id),
FOREIGN KEY (fkATM) REFERENCES ATM(idATM)
);

CREATE TABLE notificacao (
idNotificacao INT AUTO_INCREMENT PRIMARY KEY,
quantidade INT,
data_hora DATETIME,
fkComp INT,
fkATM INT,
FOREIGN KEY (fkComp) REFERENCES Componentes(id),
FOREIGN KEY (fkATM) REFERENCES ATM(idATM)
);

INSERT INTO temperaturaCPU Values
(null, 10.5, "2023-11-19 09:04:05", 3, 1);


CREATE TABLE tempoAtividade(
idTempoAtividade INT PRIMARY KEY AUTO_INCREMENT,
atividade VARCHAR(100),
fk__idATM INT,
fk__ATMAgencia INT,
fk__AgenciaEmpresa INT,
FOREIGN KEY (fk__idATM) REFERENCES ATM(idATM),
FOREIGN KEY (fk__ATMAgencia) REFERENCES ATM(AgenciaID),
FOREIGN KEY (fk__AgenciaEmpresa) REFERENCES ATM(fkAgenciaEmp)
);

CREATE TABLE API (
idAPI INT AUTO_INCREMENT PRIMARY KEY,
nome varchar(45),
linguagem varchar(45)
);

INSERT INTO API VALUES
(null, 'API Grupo', 'Kotlin'),
(null, 'API Grupo', 'Python');

-- Criando a tabela Leitura
CREATE TABLE Leitura (
    LeituraID INT AUTO_INCREMENT,
    DataRegistro DATETIME,
    Valor FLOAT,
    Componente_ID INT,
    ATMComp_ID INT,
    APIID INT,
    PRIMARY KEY (LeituraID),
    FOREIGN KEY (Componente_ID) REFERENCES Componentes(id),
    FOREIGN KEY (ATMComp_ID) REFERENCES ATM(idATM),
    FOREIGN KEY (APIID) REFERENCES API(idAPI)
);

INSERT INTO Leitura VALUES (null, '2023-11-21 18:00:00', 19, 1, 1, 1), (null, '2023-11-20 20:30:00', 54, 2, 1, 1), (null, '2023-11-22 06:50:00', 40, 3, 1, 1);

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
SELECT * FROM DescricaoComponentes;
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
SELECT * FROM rede;
select *  FROM DDoS;
SELECT * FROM temperaturaCPU;
SELECT * FROM tempoAtividade;
SELECT * FROM notificacao;

-- select uso cpu
SELECT Valor, DataRegistro
FROM Leitura
WHERE Componente_ID = 3;

-- select uso ram
SELECT Valor, DataRegistro
FROM Leitura
WHERE Componente_ID = 1;
 
 -- select quantidade de dispositivos
 SELECT COUNT(*) AS Quantidade_USB
FROM (
    SELECT DISTINCT produto, fabricante
    FROM DescricaoComponentes
) AS USB;

-- select lista de dispositivos
 SELECT produto, fabricante, dataDia
FROM DescricaoComponentes
GROUP BY produto, fabricante, dataDia
HAVING COUNT(*) > 1;
 
 SELECT DC.produto, DC.fabricante, L.Valor, L.DataRegistro
FROM Leitura L
JOIN Componentes C ON L.Componente_ID = C.id
JOIN DescricaoComponentes DC ON C.id = DC.fkComponente
WHERE DC.produto = 'Nome do Produto' AND DC.fabricante = 'Nome do Fabricante';

 
 
 SELECT * FROM DescricaoComponentes;

INSERT INTO tempoatividade VALUES
(null, '24 Dias, 12 Horas, 14 Minutos, 00 Segundos', 1, 1, 1);

SELECT ping FROM rede WHERE fk__idATM = 1;

SELECT MAX(PID) AS quantidade, DATE_FORMAT(data_hora, '%Y-%m-%d %H:00:00') AS hora, fkATM 
FROM Processos 
WHERE fkATM = 1 
GROUP BY DATE_FORMAT(data_hora, '%Y-%m-%d %H:00:00') LIMIT 3;

SELECT MAX(Valor) AS quantidade, DATE_FORMAT(DataRegistro, '%Y-%m-%d %H:00:00') AS hora, ATMComp_ID 
FROM Leitura 
WHERE ATMComp_ID = 1 AND Componente_ID = 3 
GROUP BY DATE_FORMAT(DataRegistro, '%Y-%m-%d %H:00:00') LIMIT 1;

SELECT atividade
    FROM tempoAtividade 
    WHERE fk__idATM = 1
    GROUP BY atividade
    ORDER BY atividade
    DESC LIMIT 1;

SELECT MAX(temperatura) AS temp_cpu, DATE_FORMAT(data_hora, '%Y-%m-%d %H:00:00') AS hora, fkATM 
FROM temperaturaCPU 
WHERE fkATM = 1
GROUP BY DATE_FORMAT(data_hora, '%Y-%m-%d %H:00:00');

SELECT L.Valor FROM Leitura L WHERE L.ATMComp_ID = 1 AND L.Componente_ID = 3 ORDER BY DataRegistro DESC LIMIT 1;

-- desempenho geral
 SELECT
    Leitura.ATMComp_ID,
    ROUND(AVG(CASE WHEN CodigoComponentes.idCodComponentes = 1 THEN 100 - Leitura.Valor ELSE NULL END), 2) AS MediaCPU,
    ROUND(AVG(CASE WHEN CodigoComponentes.idCodComponentes = 2 THEN 100 - Leitura.Valor ELSE NULL END), 2) AS MediaRAM,
    ROUND(AVG(CASE WHEN CodigoComponentes.idCodComponentes = 3 THEN 100 - Leitura.Valor ELSE NULL END), 2) AS MediaDisco,
    COALESCE(ROUND(AVG(100 - Leitura.Valor), 2), 100) AS DesempenhoGeral
FROM
    Leitura
JOIN
    CodigoComponentes ON Leitura.Componente_ID = CodigoComponentes.idCodComponentes
WHERE
    CodigoComponentes.idCodComponentes IN (1, 2, 3)
    AND 
    ATMComp_ID = 1
GROUP BY
    Leitura.ATMComp_ID
ORDER BY 
	Leitura.ATMComp_ID
DESC LIMIT 1;

SELECT MAX(IP) FROM rede WHERE fk__idATM = 1;
INSERT INTO rede VALUES
(null, '198.704.211', '2023-11-20 04:02:00', 100, 450, 780, 1, 1, 1 );
select * from rede;

SELECT MAX(IP) FROM rede WHERE fk__idATM = 1
    GROUP BY DATE_FORMAT(data_hora, '%Y-%m-%d %H:00:00')
    ORDER BY DATE_FORMAT(data_hora, '%Y-%m-%d %H:00:00');