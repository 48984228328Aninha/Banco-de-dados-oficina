
-- ==========================================
-- 1. PLANOS (10 registros)
-- ==========================================
INSERT INTO Planos (nomePlano, precoPlano, precoPlanoOG, emPromoPlano) VALUES
                                                                           ('Gratuito', 0.01, NULL, FALSE),
                                                                           ('Básico', 29.90, 39.90, TRUE),
                                                                           ('Essencial', 49.90, NULL, FALSE),
                                                                           ('Profissional', 79.90, 99.90, TRUE),
                                                                           ('Premium', 119.90, NULL, FALSE),
                                                                           ('Empresarial', 159.90, 199.90, TRUE),
                                                                           ('Oficina Plus', 89.90, NULL, FALSE),
                                                                           ('Oficina Pro', 139.90, 169.90, TRUE),
                                                                           ('Master', 199.90, NULL, FALSE),
                                                                           ('Enterprise', 299.90, 349.90, TRUE);


-- ==========================================
-- 2. USUARIOS (10 registros)
-- ==========================================
INSERT INTO Usuarios
(cpfUsuario, nomeUsuario, emailUsuario, celUsuario, senhaHashUsuario, nascUsuario, tipoUsuario, idPlano)
VALUES
    ('12345678901', 'Ana Souza', 'ana@email.com', '48999990001', 'hash_ana_123', '1998-03-15', FALSE, 1),
    ('23456789012', 'Bruno Lima', 'bruno@email.com', '48999990002', 'hash_bruno_123', '1995-07-22', TRUE, 2),
    ('34567890123', 'Carla Mendes', 'carla@email.com', '48999990003', 'hash_carla_123', '2000-01-10', FALSE, 3),
    ('45678901234', 'Daniel Costa', 'daniel@email.com', '48999990004', 'hash_daniel_123', '1992-11-05', TRUE, 4),
    ('56789012345', 'Eduarda Alves', 'eduarda@email.com', '48999990005', 'hash_eduarda_123', '1999-09-18', FALSE, 5),
    ('67890123456', 'Felipe Rocha', 'felipe@email.com', '48999990006', 'hash_felipe_123', '1994-06-30', TRUE, 6),
    ('78901234567', 'Gabriela Martins', 'gabriela@email.com', '48999990007', 'hash_gabi_123', '2001-12-12', FALSE, 7),
    ('89012345678', 'Henrique Oliveira', 'henrique@email.com', '48999990008', 'hash_henrique_123', '1997-04-25', TRUE, 8),
    ('90123456789', 'Isabela Ferreira', 'isabela@email.com', '48999990009', 'hash_isabela_123', '2002-08-14', FALSE, 9),
    ('01234567890', 'João Ribeiro', 'joao@email.com', '48999990010', 'hash_joao_123', '1996-02-20', TRUE, 10);


-- ==========================================
-- 3. PESSOA JURIDICA (20 registros)
-- 10 para empresas e 10 para fornecedores
-- ==========================================
INSERT INTO PessoaJuridica (cnpjPJ, contatoPJ, emailPJ) VALUES
                                                            ('12345678000101', '48988880001', 'pj01@email.com'),
                                                            ('12345678000102', '48988880002', 'pj02@email.com'),
                                                            ('12345678000103', '48988880003', 'pj03@email.com'),
                                                            ('12345678000104', '48988880004', 'pj04@email.com'),
                                                            ('12345678000105', '48988880005', 'pj05@email.com'),
                                                            ('12345678000106', '48988880006', 'pj06@email.com'),
                                                            ('12345678000107', '48988880007', 'pj07@email.com'),
                                                            ('12345678000108', '48988880008', 'pj08@email.com'),
                                                            ('12345678000109', '48988880009', 'pj09@email.com'),
                                                            ('12345678000110', '48988880010', 'pj10@email.com'),
                                                            ('98765432000101', '48977770001', 'fornecedor01@email.com'),
                                                            ('98765432000102', '48977770002', 'fornecedor02@email.com'),
                                                            ('98765432000103', '48977770003', 'fornecedor03@email.com'),
                                                            ('98765432000104', '48977770004', 'fornecedor04@email.com'),
                                                            ('98765432000105', '48977770005', 'fornecedor05@email.com'),
                                                            ('98765432000106', '48977770006', 'fornecedor06@email.com'),
                                                            ('98765432000107', '48977770007', 'fornecedor07@email.com'),
                                                            ('98765432000108', '48977770008', 'fornecedor08@email.com'),
                                                            ('98765432000109', '48977770009', 'fornecedor09@email.com'),
                                                            ('98765432000110', '48977770010', 'fornecedor10@email.com');


-- ==========================================
-- 4. EMPRESA (10 registros)
-- ==========================================
INSERT INTO Empresa
(nomeEmpresa, descEmpresa, siteEmpresa, razaoSocialEmpresa, nomeFantasiaEmpresa, idPJ)
VALUES
    ('Auto Center Sul', 'Oficina especializada em manutenção automotiva.', 'www.autocentersul.com.br', 'Auto Center Sul LTDA', 'Auto Center Sul', 1),
    ('Mecânica Avenida', 'Serviços de mecânica geral.', 'www.mecanicaavenida.com.br', 'Mecanica Avenida LTDA', 'Mecânica Avenida', 2),
    ('Oficina do João', 'Manutenção preventiva e corretiva.', NULL, 'Joao Oficina LTDA', 'Oficina do João', 3),
    ('Car Service', 'Centro automotivo completo.', 'www.carservice.com.br', 'Car Service LTDA', 'Car Service', 4),
    ('Motor Forte', 'Especializada em motores e transmissão.', NULL, 'Motor Forte LTDA', 'Motor Forte', 5),
    ('AutoTech', 'Diagnóstico eletrônico automotivo.', 'www.autotech.com.br', 'AutoTech LTDA', 'AutoTech', 6),
    ('Mecânica Central', 'Serviços de revisão e manutenção.', NULL, 'Mecanica Central LTDA', 'Mecânica Central', 7),
    ('Garage Premium', 'Oficina especializada em veículos premium.', 'www.garagepremium.com.br', 'Garage Premium LTDA', 'Garage Premium', 8),
    ('Rota Auto', 'Serviços automotivos em geral.', NULL, 'Rota Auto LTDA', 'Rota Auto', 9),
    ('Box 10 Mecânica', 'Manutenção e reparação de automóveis.', 'www.box10.com.br', 'Box 10 Mecanica LTDA', 'Box 10 Mecânica', 10);


-- ==========================================
-- 5. LOCALIZACAO (10 registros)
-- ==========================================
INSERT INTO Localizacao (cepLocal, endLocal, areaLocal, idEmpresa) VALUES
                                                                       ('88130000', 'Rua das Flores, 100 - Palhoça/SC', 250.00, 1),
                                                                       ('88130100', 'Avenida Central, 250 - Palhoça/SC', 180.00, 2),
                                                                       ('88010000', 'Rua Felipe Schmidt, 300 - Florianópolis/SC', 320.00, 3),
                                                                       ('88020000', 'Rua Santos Saraiva, 450 - Florianópolis/SC', 210.00, 4),
                                                                       ('88110000', 'Rua São José, 120 - São José/SC', 150.00, 5),
                                                                       ('88110200', 'Avenida das Torres, 800 - São José/SC', 400.00, 6),
                                                                       ('88035000', 'Rua Bocaiúva, 90 - Florianópolis/SC', 280.00, 7),
                                                                       ('88132000', 'Rua Independência, 500 - Palhoça/SC', 350.00, 8),
                                                                       ('88045000', 'Avenida Beira-Mar, 700 - Florianópolis/SC', 500.00, 9),
                                                                       ('88133000', 'Rua do Comércio, 150 - Palhoça/SC', 190.00, 10);


-- ==========================================
-- 6. SERVICO (10 registros)
-- ==========================================
INSERT INTO Servico (nomeServico, precoServico, duracaoServico, statusServico) VALUES
                                                                                   ('Troca de óleo', 120.00, '00:40:00', 'ATIVO'),
                                                                                   ('Alinhamento', 90.00, '01:00:00', 'ATIVO'),
                                                                                   ('Balanceamento', 70.00, '00:50:00', 'ATIVO'),
                                                                                   ('Revisão completa', 450.00, '03:00:00', 'ATIVO'),
                                                                                   ('Troca de pastilhas', 180.00, '01:30:00', 'ATIVO'),
                                                                                   ('Diagnóstico eletrônico', 150.00, '01:00:00', 'ATIVO'),
                                                                                   ('Troca de bateria', 80.00, '00:30:00', 'ATIVO'),
                                                                                   ('Higienização do ar-condicionado', 200.00, '02:00:00', 'ATIVO'),
                                                                                   ('Reparo de suspensão', 350.00, '02:30:00', 'ATIVO'),
                                                                                   ('Troca de correia dentada', 600.00, '04:00:00', 'ATIVO');


-- ==========================================
-- 7. PECA (10 registros)
-- ==========================================
INSERT INTO Peca
(modeloPeca, descPeca, precoPeca, precoPecaOG, quantPeca, emPromoPeca)
VALUES
    ('Filtro de óleo Wega', 'Filtro de óleo para motores automotivos.', 35.90, 45.90, 20, TRUE),
    ('Pastilha de freio Bosch', 'Jogo de pastilhas de freio dianteiras.', 120.00, NULL, 15, FALSE),
    ('Vela NGK', 'Vela de ignição automotiva.', 28.50, NULL, 40, FALSE),
    ('Bateria Moura 60Ah', 'Bateria automotiva de 60 amperes.', 520.00, 580.00, 8, TRUE),
    ('Correia dentada Gates', 'Correia dentada para motor.', 95.00, NULL, 12, FALSE),
    ('Amortecedor Cofap', 'Amortecedor dianteiro.', 310.00, 350.00, 10, TRUE),
    ('Filtro de ar Tecfil', 'Filtro de ar para motor.', 42.00, NULL, 25, FALSE),
    ('Óleo 5W30', 'Óleo lubrificante sintético 1 litro.', 39.90, 49.90, 50, TRUE),
    ('Disco de freio TRW', 'Disco de freio dianteiro.', 210.00, NULL, 14, FALSE),
    ('Kit embreagem Luk', 'Kit de embreagem completo.', 780.00, 850.00, 5, TRUE);


-- ==========================================
-- 8. FORNECEDOR (10 registros)
-- ==========================================
INSERT INTO Fornecedor (nomeFornecedor, idPJ) VALUES
                                                  ('Distribuidora Auto Peças Sul', 11),
                                                  ('Peças Brasil', 12),
                                                  ('Mundo Automotivo', 13),
                                                  ('Auto Parts Center', 14),
                                                  ('Distribuidora São José', 15),
                                                  ('Peças e Motores LTDA', 16),
                                                  ('Sul Peças Automotivas', 17),
                                                  ('Comercial do Automóvel', 18),
                                                  ('Central das Peças', 19),
                                                  ('Mega Distribuidora', 20);


-- ==========================================
-- 9. FORNECEDORPECA (10 registros)
-- ==========================================
INSERT INTO FornecedorPeca (idFornecedor, idPeca) VALUES
                                                      (1, 1),
                                                      (2, 2),
                                                      (3, 3),
                                                      (4, 4),
                                                      (5, 5),
                                                      (6, 6),
                                                      (7, 7),
                                                      (8, 8),
                                                      (9, 9),
                                                      (10, 10);


-- ==========================================
-- 10. HORARIODISPONIVEL (10 registros)
-- ==========================================
INSERT INTO HorarioDisponivel
(diaSemana, aberturaHorario, fechamentoHorario, fechado, idEmpresa)
VALUES
    (1, '08:00:00', '18:00:00', FALSE, 1),
    (2, '08:00:00', '18:00:00', FALSE, 2),
    (3, '08:30:00', '17:30:00', FALSE, 3),
    (4, '08:00:00', '18:00:00', FALSE, 4),
    (5, '08:00:00', '18:00:00', FALSE, 5),
    (6, '08:00:00', '12:00:00', FALSE, 6),
    (1, '09:00:00', '18:00:00', FALSE, 7),
    (2, '08:00:00', '17:00:00', FALSE, 8),
    (3, '08:00:00', '18:00:00', FALSE, 9),
    (4, '08:00:00', '17:00:00', FALSE, 10);


-- ==========================================
-- 11. HISTORICOPRECOSPLANO (10 registros)
-- ==========================================
INSERT INTO HistoricoPrecosPlano
(precoAntigoPlano, precoNovoPlano, idPlano)
VALUES
    (25.00, 29.90, 1),
    (35.00, 39.90, 2),
    (45.00, 49.90, 3),
    (69.90, 79.90, 4),
    (109.90, 119.90, 5),
    (149.90, 159.90, 6),
    (79.90, 89.90, 7),
    (129.90, 139.90, 8),
    (189.90, 199.90, 9),
    (279.90, 299.90, 10);


-- ==========================================
-- 12. HISTORICOPRECOSPECA (10 registros)
-- ==========================================
INSERT INTO HistoricoPrecosPeca
(precoAntigoPeca, precoNovoPeca, idPeca)
VALUES
    (32.90, 35.90, 1),
    (110.00, 120.00, 2),
    (25.00, 28.50, 3),
    (490.00, 520.00, 4),
    (89.00, 95.00, 5),
    (290.00, 310.00, 6),
    (38.00, 42.00, 7),
    (35.90, 39.90, 8),
    (195.00, 210.00, 9),
    (750.00, 780.00, 10);


-- ==========================================
-- 13. HISTORICOESTOQUE (10 registros)
-- ==========================================
INSERT INTO HistoricoEstoque
(tipoMovimentacao, quantidade, idPeca)
VALUES
    ('ENTRADA', 20, 1),
    ('SAIDA', 5, 2),
    ('ENTRADA', 30, 3),
    ('SAIDA', 2, 4),
    ('ENTRADA', 15, 5),
    ('SAIDA', 3, 6),
    ('ENTRADA', 25, 7),
    ('SAIDA', 10, 8),
    ('ENTRADA', 12, 9),
    ('SAIDA', 1, 10);


-- ==========================================
-- CONSULTA PARA CONFERIR OS REGISTROS
-- ==========================================
SELECT * FROM Planos;
SELECT * FROM Usuarios;
SELECT * FROM PessoaJuridica;
SELECT * FROM Empresa;
SELECT * FROM Localizacao;
SELECT * FROM Servico;
SELECT * FROM Peca;
SELECT * FROM Fornecedor;
SELECT * FROM FornecedorPeca;
SELECT * FROM HorarioDisponivel;
SELECT * FROM HistoricoPrecosPlano;
SELECT * FROM HistoricoPrecosPeca;
SELECT * FROM HistoricoEstoque;
