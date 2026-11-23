
-- ==========================================
-- DDL - GARAGEHUBBD
-- Data Definition Language
-- ==========================================

CREATE DATABASE IF NOT EXISTS GarageHubBD;

USE GarageHubBD;

-- ==========================================
-- 1. TABELA PLANOS
-- ==========================================

CREATE TABLE Planos (
                        idPlano INT PRIMARY KEY AUTO_INCREMENT,
                        nomePlano VARCHAR(100) NOT NULL,
                        precoPlano DECIMAL(10,2) NOT NULL,
                        precoPlanoOG DECIMAL(10,2),
                        emPromoPlano BOOLEAN DEFAULT FALSE,
                        atualizadoPlano DATETIME DEFAULT CURRENT_TIMESTAMP,
                        CONSTRAINT chk_preco_plano CHECK (precoPlano > 0),
                        CONSTRAINT chk_preco_plano_og CHECK (
                            precoPlanoOG IS NULL OR precoPlanoOG > 0
                            )
);

-- ==========================================
-- 2. TABELA USUARIOS
-- ==========================================

CREATE TABLE Usuarios (
                          idUsuario INT PRIMARY KEY AUTO_INCREMENT,
                          cpfUsuario VARCHAR(14) NOT NULL UNIQUE,
                          nomeUsuario VARCHAR(100) NOT NULL,
                          emailUsuario VARCHAR(100) NOT NULL UNIQUE,
                          celUsuario VARCHAR(20),
                          senhaHashUsuario VARCHAR(255) NOT NULL,
                          nascUsuario DATE,
                          tipoUsuario VARCHAR(30) NOT NULL,
                          idPlano INT,

                          CONSTRAINT fk_usuarios_planos
                              FOREIGN KEY (idPlano)
                                  REFERENCES Planos(idPlano)
);

-- ==========================================
-- 3. TABELA PESSOAJURIDICA
-- ==========================================

CREATE TABLE PessoaJuridica (
                                idPJ INT PRIMARY KEY AUTO_INCREMENT,
                                cnpjPJ VARCHAR(18) NOT NULL UNIQUE,
                                cadastroPJ DATE NOT NULL DEFAULT (CURRENT_DATE),
                                contatoPJ VARCHAR(100),
                                emailPJ VARCHAR(100)
);

-- ==========================================
-- 4. TABELA EMPRESA
-- ==========================================

CREATE TABLE Empresa (
                         idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
                         nomeEmpresa VARCHAR(100) NOT NULL,
                         descEmpresa TEXT,
                         siteEmpresa VARCHAR(255),
                         razaoSocialEmpresa VARCHAR(150),
                         nomeFantasiaEmpresa VARCHAR(150),
                         idPJ INT NOT NULL UNIQUE,

                         CONSTRAINT fk_empresa_pj
                             FOREIGN KEY (idPJ)
                                 REFERENCES PessoaJuridica(idPJ)
);

-- ==========================================
-- 5. TABELA LOCALIZACAO
-- ==========================================

CREATE TABLE Localizacao (
                             idLocal INT PRIMARY KEY AUTO_INCREMENT,
                             cepLocal VARCHAR(10),
                             endLocal VARCHAR(255) NOT NULL,
                             areaLocal VARCHAR(100),
                             idEmpresa INT NOT NULL,

                             CONSTRAINT fk_localizacao_empresa
                                 FOREIGN KEY (idEmpresa)
                                     REFERENCES Empresa(idEmpresa)
);

-- ==========================================
-- 6. TABELA SERVICO
-- ==========================================

CREATE TABLE Servico (
                         idServico INT PRIMARY KEY AUTO_INCREMENT,
                         nomeServico VARCHAR(100) NOT NULL,
                         precoServico DECIMAL(10,2) NOT NULL,
                         duracaoServico INT,
                         statusServico VARCHAR(30),

                         CONSTRAINT chk_preco_servico
                             CHECK (precoServico > 0)
);

-- ==========================================
-- 7. TABELA PECA
-- ==========================================

CREATE TABLE Peca (
                      idPeca INT PRIMARY KEY AUTO_INCREMENT,
                      modeloPeca VARCHAR(100) NOT NULL,
                      descPeca TEXT,
                      precoPeca DECIMAL(10,2) NOT NULL,
                      precoPecaOG DECIMAL(10,2),
                      quantPeca INT NOT NULL DEFAULT 0,
                      emPromoPeca BOOLEAN DEFAULT FALSE,
                      atualizadoPeca DATETIME DEFAULT CURRENT_TIMESTAMP,

                      CONSTRAINT chk_preco_peca
                          CHECK (precoPeca > 0),

                      CONSTRAINT chk_preco_peca_og
                          CHECK (precoPecaOG IS NULL OR precoPecaOG > 0),

                      CONSTRAINT chk_quant_peca
                          CHECK (quantPeca >= 0)
);

-- ==========================================
-- 8. TABELA FORNECEDOR
-- ==========================================

CREATE TABLE Fornecedor (
                            idFornecedor INT PRIMARY KEY AUTO_INCREMENT,
                            nomeFornecedor VARCHAR(100) NOT NULL,
                            idPJ INT NOT NULL UNIQUE,

                            CONSTRAINT fk_fornecedor_pj
                                FOREIGN KEY (idPJ)
                                    REFERENCES PessoaJuridica(idPJ)
);

-- ==========================================
-- 9. TABELA FORNECEDORPECA
-- ==========================================

CREATE TABLE FornecedorPeca (
                                idFP INT PRIMARY KEY AUTO_INCREMENT,
                                idFornecedor INT NOT NULL UNIQUE,
                                idPeca INT NOT NULL UNIQUE,

                                CONSTRAINT fk_fornecedorpeca_fornecedor
                                    FOREIGN KEY (idFornecedor)
                                        REFERENCES Fornecedor(idFornecedor),

                                CONSTRAINT fk_fornecedorpeca_peca
                                    FOREIGN KEY (idPeca)
                                        REFERENCES Peca(idPeca)
);

-- ==========================================
-- 10. TABELA HORARIODISPONIVEL
-- ==========================================

CREATE TABLE HorarioDisponivel (
                                   idHorario INT PRIMARY KEY AUTO_INCREMENT,
                                   diaSemana INT NOT NULL,
                                   aberturaHorario TIME,
                                   fechamentoHorario TIME,
                                   fechado BOOLEAN DEFAULT FALSE,
                                   idEmpresa INT NOT NULL,

                                   CONSTRAINT fk_horario_empresa
                                       FOREIGN KEY (idEmpresa)
                                           REFERENCES Empresa(idEmpresa),

                                   CONSTRAINT uq_horario_empresa_dia
                                       UNIQUE (idEmpresa, diaSemana),

                                   CONSTRAINT chk_dia_semana
                                       CHECK (diaSemana BETWEEN 1 AND 7),

                                   CONSTRAINT chk_horario
                                       CHECK (
                                           (fechado = TRUE
                                               AND aberturaHorario IS NULL
                                               AND fechamentoHorario IS NULL)
                                               OR
                                           (fechado = FALSE
                                               AND aberturaHorario IS NOT NULL
                                               AND fechamentoHorario IS NOT NULL
                                               AND aberturaHorario < fechamentoHorario)
                                           )
);

-- ==========================================
-- 11. TABELA HISTORICOPRECOSPLANO
-- ==========================================

CREATE TABLE HistoricoPrecosPlano (
                                      idHistoricoPlano INT PRIMARY KEY AUTO_INCREMENT,
                                      precoAntigoPlano DECIMAL(10,2) NOT NULL,
                                      precoNovoPlano DECIMAL(10,2) NOT NULL,
                                      dataAlteracaoPlano DATETIME DEFAULT CURRENT_TIMESTAMP,
                                      idPlano INT NOT NULL,

                                      CONSTRAINT fk_historicoplano_plano
                                          FOREIGN KEY (idPlano)
                                              REFERENCES Planos(idPlano)
);

-- ==========================================
-- 12. TABELA HISTORICOPRECOSPECA
-- ==========================================

CREATE TABLE HistoricoPrecosPeca (
                                     idHistoricoPeca INT PRIMARY KEY AUTO_INCREMENT,
                                     precoAntigoPeca DECIMAL(10,2) NOT NULL,
                                     precoNovoPeca DECIMAL(10,2) NOT NULL,
                                     dataAlteracaoPeca DATETIME DEFAULT CURRENT_TIMESTAMP,
                                     idPeca INT NOT NULL,

                                     CONSTRAINT fk_historicopeca_peca
                                         FOREIGN KEY (idPeca)
                                             REFERENCES Peca(idPeca)
);

-- ==========================================
-- 13. TABELA HISTORICOESTOQUE
-- ==========================================

CREATE TABLE HistoricoEstoque (
                                  idMovimentacao INT PRIMARY KEY AUTO_INCREMENT,
                                  tipoMovimentacao ENUM('ENTRADA', 'SAIDA') NOT NULL,
                                  quantidade INT NOT NULL,
                                  dataMovimentacao DATETIME DEFAULT CURRENT_TIMESTAMP,
                                  idPeca INT NOT NULL,

                                  CONSTRAINT fk_historicoestoque_peca
                                      FOREIGN KEY (idPeca)
                                          REFERENCES Peca(idPeca),

                                  CONSTRAINT chk_quantidade_movimentacao
                                      CHECK (quantidade > 0)
);
