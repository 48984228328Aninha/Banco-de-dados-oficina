-- ==========================================
-- CRIAR ADMIN
-- ==========================================
CREATE USER 'admin'@'%' IDENTIFIED BY 'Oficina@Oficina2026';
GRANT ALL PRIVILEGES ON GarageHubBD.* TO 'admin'@'%';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'admin'@'%';

-- ==========================================
-- CRIAR BACKUP
-- ==========================================
CREATE USER 'backup_user'@'%' IDENTIFIED BY 'backup@backupp2026';
GRANT SELECT, LOCK TABLES, SHOW VIEW, EVENT, TRIGGER ON GarageHubBD.* TO 'backup_user'@'%';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'backup_user'@'%';

-- ==========================================
-- CRIAR AUDITOR
-- ==========================================
CREATE USER 'auditor'@'%' IDENTIFIED BY 'auditor@auditorr2026';
GRANT SELECT ON mysql.* TO 'auditor'@'%';
GRANT PROCESS ON *.* TO 'auditor'@'%';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'auditor'@'%';

-- ==========================================
-- CRIAR USUÁRIO DEV
-- ==========================================
CREATE USER 'dev_user'@'%' IDENTIFIED BY 'dev@dev2026';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER, INDEX, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROTINE, EXECUTE ON GarageHubBD.* TO 'dev_user'@'%';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'dev_user'@'%';

-- ==========================================
-- CRIAR LEITURA DE BI
-- ==========================================
CREATE USER 'bi_leitura'@'%' IDENTIFIED BY 'bi_leitura@bi_leitura2026';
GRANT SELECT, SHOW VIEW ON GarageHubBD.* TO 'bi_leitura'@'%';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'backup_user'@'%';

-- ==========================================
-- SE SOFRER ATAQUE
-- ==========================================
CREATE USER 'app_garagehub'@'%' IDENTIFIED BY 'garagehub@garagehub2026';
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE ON mysql.* TO 'app_garagehub'@'%';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'app_garagehub'@'%';