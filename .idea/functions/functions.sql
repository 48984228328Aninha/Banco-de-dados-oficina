-- Funções, Triggers, Procedures e Relatórios do GarageHubBD

-- Funções
-- ============================================================

DELIMITER //

-- Verifica se o usuario e administrador

CREATE FUNCTION verificar_admin(
    p_usuario_id INT
)
    RETURNS BOOLEAN
    NOT DETERMINISTIC
    READS SQL DATA
BEGIN
RETURN EXISTS (
    SELECT 1
    FROM Usuarios
    WHERE idUsuario = p_usuario_id
      AND tipoUsuario = TRUE
);
END //

-- Calcula o preco com desconto

CREATE FUNCTION calcularDesconto(
    p_preco DECIMAL(10,2),
    p_desconto DECIMAL(5,2)
)
    RETURNS DECIMAL(10,2)
    DETERMINISTIC
    NO SQL
BEGIN
RETURN p_preco - (p_preco * p_desconto / 100);
END //

-- Conta todas as pecas cadastradas

CREATE FUNCTION contarPecas()
    RETURNS INT
    NOT DETERMINISTIC
    READS SQL DATA
BEGIN
    DECLARE total INT;

SELECT COUNT(*)
INTO total
FROM Peca;

RETURN total;
END //

-- Conta todos os planos cadastrados

CREATE FUNCTION contarPlanos()
    RETURNS INT
    NOT DETERMINISTIC
    READS SQL DATA
BEGIN
    DECLARE total INT;

SELECT COUNT(*)
INTO total
FROM Planos;

RETURN total;
END //

-- Verifica se existe estoque disponivel

CREATE FUNCTION verificarEstoque(
    p_idPeca INT
)
    RETURNS BOOLEAN
    NOT DETERMINISTIC
    READS SQL DATA
BEGIN
RETURN EXISTS (
    SELECT 1
    FROM Peca
    WHERE idPeca = p_idPeca
      AND quantPeca > 0
);
END //

-- Calcula a media dos precos das pecas

CREATE FUNCTION calcularMediaPrecosPecas()
    RETURNS DECIMAL(10,2)
    NOT DETERMINISTIC
    READS SQL DATA
BEGIN
    DECLARE media DECIMAL(10,2);

SELECT AVG(precoPeca)
INTO media
FROM Peca;

RETURN media;
END //

-- Calcula a media dos precos dos planos

CREATE FUNCTION calcularMediaPrecosPlanos()
    RETURNS DECIMAL(10,2)
    NOT DETERMINISTIC
    READS SQL DATA
BEGIN
    DECLARE media DECIMAL(10,2);

SELECT AVG(precoPlano)
INTO media
FROM Planos;

RETURN media;
END //

DELIMITER ;

-- Procedures de Promoção
-- ============================================================

DELIMITER //

-- Aplica promocao em uma peca

CREATE PROCEDURE aplicarPromocaoPeca(
    IN p_idPeca INT,
    IN p_desconto DECIMAL(5,2)
)
BEGIN
    IF p_desconto <= 0 OR p_desconto >= 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Desconto deve ser entre 0 e 100';
END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM Peca
        WHERE idPeca = p_idPeca
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Peca nao encontrada';
END IF;

    IF EXISTS (
        SELECT 1
        FROM Peca
        WHERE idPeca = p_idPeca
          AND emPromoPeca = TRUE
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Peca ja esta em promocao';
END IF;

UPDATE Peca
SET
    precoPecaOG = precoPeca,
    precoPeca = calcularDesconto(precoPeca, p_desconto),
    emPromoPeca = TRUE,
    atualizadoPeca = NOW()
WHERE idPeca = p_idPeca;
END //

-- Encerra promocao da peca

CREATE PROCEDURE encerrarPromocaoPeca(
    IN p_idPeca INT
)
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM Peca
        WHERE idPeca = p_idPeca
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Peca nao encontrada';
END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM Peca
        WHERE idPeca = p_idPeca
          AND emPromoPeca = TRUE
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Peca nao esta em promocao';
END IF;

UPDATE Peca
SET
    precoPeca = precoPecaOG,
    precoPecaOG = NULL,
    emPromoPeca = FALSE,
    atualizadoPeca = NOW()
WHERE idPeca = p_idPeca;
END //

-- Aplica promocao em um plano

CREATE PROCEDURE aplicarPromocaoPlano(
    IN p_idPlano INT,
    IN p_desconto DECIMAL(5,2)
)
BEGIN
    IF p_desconto <= 0 OR p_desconto >= 100 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Desconto deve ser entre 0 e 100';
END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM Planos
        WHERE idPlano = p_idPlano
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Plano nao encontrado';
END IF;

    IF EXISTS (
        SELECT 1
        FROM Planos
        WHERE idPlano = p_idPlano
          AND emPromoPlano = TRUE
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Plano ja esta em promocao';
END IF;

UPDATE Planos
SET
    precoPlanoOG = precoPlano,
    precoPlano = calcularDesconto(precoPlano, p_desconto),
    emPromoPlano = TRUE,
    atualizadoPlano = NOW()
WHERE idPlano = p_idPlano;
END //


-- Encerra promocao do plano

CREATE PROCEDURE encerrarPromocaoPlano(
    IN p_idPlano INT
)
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM Planos
        WHERE idPlano = p_idPlano
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Plano nao encontrado';
END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM Planos
        WHERE idPlano = p_idPlano
          AND emPromoPlano = TRUE
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Plano nao esta em promocao';
END IF;

UPDATE Planos
SET
    precoPlano = precoPlanoOG,
    precoPlanoOG = NULL,
    emPromoPlano = FALSE,
    atualizadoPlano = NOW()
WHERE idPlano = p_idPlano;
END //

DELIMITER ;

-- Procedures de atualização de preço
-- ============================================================

DELIMITER //

-- Atualiza preco de uma peca

CREATE PROCEDURE atualizarPrecoPeca(
    IN p_idPeca INT,
    IN p_novoPreco DECIMAL(10,2)
)
BEGIN
    IF p_novoPreco <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Preco deve ser maior que zero';
END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM Peca
        WHERE idPeca = p_idPeca
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Peca nao encontrada';
END IF;

    IF EXISTS (
        SELECT 1
        FROM Peca
        WHERE idPeca = p_idPeca
          AND emPromoPeca = TRUE
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Encerre a promocao antes de alterar o preco';
END IF;

UPDATE Peca
SET
    precoPeca = p_novoPreco,
    atualizadoPeca = NOW()
WHERE idPeca = p_idPeca;
END //

-- Atualiza preco de um plano

CREATE PROCEDURE atualizarPrecoPlano(
    IN p_idPlano INT,
    IN p_novoPreco DECIMAL(10,2)
)
BEGIN
    IF p_novoPreco <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Preco deve ser maior que zero';
END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM Planos
        WHERE idPlano = p_idPlano
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Plano nao encontrado';
END IF;

    IF EXISTS (
        SELECT 1
        FROM Planos
        WHERE idPlano = p_idPlano
          AND emPromoPlano = TRUE
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Encerre a promocao antes de alterar o preco';
END IF;

UPDATE Planos
SET
    precoPlano = p_novoPreco,
    atualizadoPlano = NOW()
WHERE idPlano = p_idPlano;
END //

DELIMITER ;

-- Procedures de Estoque
-- ============================================================

DELIMITER //

-- Adiciona unidades ao estoque

CREATE PROCEDURE adicionarEstoque(
    IN p_idPeca INT,
    IN p_quantidade INT
)
BEGIN
    DECLARE v_existente INT DEFAULT 0;

    IF p_quantidade <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Quantidade deve ser maior que zero';
END IF;

SELECT COUNT(*)
INTO v_existente
FROM Peca
WHERE idPeca = p_idPeca;

IF v_existente = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Peca nao encontrada';
END IF;

UPDATE Peca
SET quantPeca = quantPeca + p_quantidade
WHERE idPeca = p_idPeca;

INSERT INTO HistoricoEstoque (
    idPeca,
    tipoMovimentacao,
    quantidade
)
VALUES (
           p_idPeca,
           'ENTRADA',
           p_quantidade
       );
END //

-- Retira unidades do estoque

CREATE PROCEDURE retirarEstoque(
    IN p_idPeca INT,
    IN p_quantidade INT
)
BEGIN
    IF p_quantidade <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Quantidade deve ser maior que zero';
END IF;

UPDATE Peca
SET quantPeca = quantPeca - p_quantidade
WHERE idPeca = p_idPeca
  AND quantPeca >= p_quantidade;

IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Peca inexistente ou estoque insuficiente';
END IF;

INSERT INTO HistoricoEstoque (
    idPeca,
    tipoMovimentacao,
    quantidade
)
VALUES (
           p_idPeca,
           'SAIDA',
           p_quantidade
       );
END //

DELIMITER ;

-- Procedures de Relatório
-- ============================================================

DELIMITER //

-- Relatorio geral do sistema

CREATE PROCEDURE relatorioGeral()
BEGIN
SELECT
    (SELECT COUNT(*) FROM Usuarios)
        AS totalUsuarios,

    (SELECT COUNT(*) FROM Empresa)
        AS totalEmpresas,

    (SELECT COUNT(*) FROM Peca)
        AS totalPecas,

    (SELECT COUNT(*) FROM Fornecedor)
        AS totalFornecedores,

    (SELECT COUNT(*) FROM Planos)
        AS totalPlanos,

    (SELECT COUNT(*) FROM Peca
     WHERE emPromoPeca = TRUE)
        AS pecasEmPromocao,

    (SELECT COUNT(*) FROM Planos
     WHERE emPromoPlano = TRUE)
        AS planosEmPromocao,

    (SELECT COUNT(*) FROM Peca
     WHERE quantPeca = 0)
        AS pecasSemEstoque;
END //

-- Relatorio de todas as pecas

CREATE PROCEDURE relatorioPecas()
BEGIN
SELECT
    idPeca,
    modeloPeca,
    precoPeca,
    precoPecaOG,
    quantPeca,
    emPromoPeca,
    atualizadoPeca
FROM Peca
ORDER BY modeloPeca;
END //

-- Relatorio de todos os planos

CREATE PROCEDURE relatorioPlanos()
BEGIN
SELECT
    idPlano,
    nomePlano,
    precoPlano,
    precoPlanoOG,
    emPromoPlano,
    atualizadoPlano
FROM Planos
ORDER BY nomePlano;
END //


-- Relatorio de pecas em promocao

CREATE PROCEDURE relatorioPecasPromocao()
BEGIN
SELECT
    idPeca,
    modeloPeca,
    precoPecaOG,
    precoPeca
FROM Peca
WHERE emPromoPeca = TRUE;
END //

-- Relatorio de planos em promocao

CREATE PROCEDURE relatorioPlanosPromocao()
BEGIN
SELECT
    idPlano,
    nomePlano,
    precoPlanoOG,
    precoPlano
FROM Planos
WHERE emPromoPlano = TRUE;
END //

-- Relatorio de estoque baixo

CREATE PROCEDURE relatorioEstoqueBaixo(
    IN p_limite INT
)
BEGIN
SELECT
    idPeca,
    modeloPeca,
    quantPeca
FROM Peca
WHERE quantPeca <= p_limite
ORDER BY quantPeca ASC;
END //

-- Relatorio de pecas de um fornecedor

CREATE PROCEDURE relatorioPecasFornecedor(
    IN p_idFornecedor INT
)
BEGIN
SELECT
    F.nomeFornecedor,
    P.idPeca,
    P.modeloPeca,
    P.precoPeca,
    P.quantPeca
FROM Fornecedor F
         INNER JOIN FornecedorPeca FP
                    ON F.idFornecedor = FP.idFornecedor
         INNER JOIN Peca P
                    ON FP.idPeca = P.idPeca
WHERE F.idFornecedor = p_idFornecedor;
END //

-- Relatorio de usuarios e seus planos

CREATE PROCEDURE relatorioUsuariosPlano(
    IN p_idPlano INT
)
BEGIN
SELECT
    U.idUsuario,
    U.nomeUsuario,
    U.emailUsuario,
    P.nomePlano,
    P.precoPlano
FROM Usuarios U
         INNER JOIN Planos P
                    ON U.idPlano = P.idPlano
WHERE P.idPlano = p_idPlano;
END //

DELIMITER ;

-- Triggers do Histórico de preços
-- ============================================================

DELIMITER //

-- Registra alteracoes de preco das pecas

CREATE TRIGGER registrarHistoricoPrecoPeca
    AFTER UPDATE ON Peca
    FOR EACH ROW
BEGIN
    IF OLD.precoPeca <> NEW.precoPeca THEN

        INSERT INTO HistoricoPrecosPeca (
            precoAntigoPeca,
            precoNovoPeca,
            idPeca
        )
        VALUES (
            OLD.precoPeca,
            NEW.precoPeca,
            OLD.idPeca
        );

END IF;
END //

-- Registra alteracoes de preco dos planos

CREATE TRIGGER registrarHistoricoPrecoPlano
    AFTER UPDATE ON Planos
    FOR EACH ROW
BEGIN
    IF OLD.precoPlano <> NEW.precoPlano THEN

        INSERT INTO HistoricoPrecosPlano (
            precoAntigoPlano,
            precoNovoPlano,
            idPlano
        )
        VALUES (
            OLD.precoPlano,
            NEW.precoPlano,
            OLD.idPlano
        );

END IF;
END //

DELIMITER ;

-- Teste de Funções
-- ============================================================

-- Verifica se o usuario 1 e administrador

SELECT verificar_admin(1);

-- Calcula 20% de desconto em R$ 100,00

SELECT calcularDesconto(100.00, 20);

-- Conta pecas cadastradas

SELECT contarPecas();

-- Conta planos cadastrados

SELECT contarPlanos();

-- Verifica estoque da peca 1

SELECT verificarEstoque(1);

-- Media dos precos das pecas

SELECT calcularMediaPrecosPecas();

-- Media dos precos dos planos

SELECT calcularMediaPrecosPlanos();

-- Teste de Procedures
-- ============================================================

-- Aplicar promocao de 20% na peca 1

CALL aplicarPromocaoPeca(1, 20);

-- Encerrar promocao da peca 1

CALL encerrarPromocaoPeca(1);

-- Aplicar promocao de 20% no plano 1

CALL aplicarPromocaoPlano(1, 20);

-- Encerrar promocao do plano 1

CALL encerrarPromocaoPlano(1);

-- Atualizar preco da peca 1

CALL atualizarPrecoPeca(1, 150.00);

-- Atualizar preco do plano 1

CALL atualizarPrecoPlano(1, 99.90);

-- Adicionar 10 unidades ao estoque da peca 1

CALL adicionarEstoque(1, 10);

-- Retirar 3 unidades do estoque da peca 1

CALL retirarEstoque(1, 3);

-- Relatórios
-- ============================================================

-- Relatorio geral

CALL relatorioGeral();

-- Relatorio de pecas

CALL relatorioPecas();

-- Relatorio de planos

CALL relatorioPlanos();

-- Relatorio de pecas em promocao

CALL relatorioPecasPromocao();

-- Relatorio de planos em promocao

CALL relatorioPlanosPromocao();

-- Relatorio de estoque baixo

CALL relatorioEstoqueBaixo(5);

-- Relatorio de pecas do fornecedor 1

CALL relatorioPecasFornecedor(1);

-- Relatorio de usuarios do plano 1

CALL relatorioUsuariosPlano(1);

-- Consultas Diretas
-- ============================================================

-- Consultar pecas

SELECT * FROM Peca;

-- Consultar planos

SELECT * FROM Planos;

-- Consultar historico de precos das pecas

SELECT *
FROM HistoricoPrecosPeca
ORDER BY dataAlteracaoPeca DESC;

-- Consultar historico de precos dos planos

SELECT *
FROM HistoricoPrecosPlano
ORDER BY dataAlteracaoPlano DESC;

-- Consultar movimentacoes do estoque

SELECT *
FROM HistoricoEstoque
ORDER BY dataMovimentacao DESC;