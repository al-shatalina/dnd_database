<!-- СОЗДАНИЕ ПОЛЬЗОВАТЕЛЯ -->
CREATE USER 'ME'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'ME'@'localhost' IDENTIFIED BY 'password' WITH  MAX_QUERIES_PER_HOUR 20;
CREATE USER 'ME'@'localhost' IDENTIFIED BY 'password' WITH MAX_UPDATES_PER_HOUR 10;
CREATE USER 'ME'@'localhost' IDENTIFIED BY 'password' WITH MAX_CONNECTIONS_PER_HOUR 5;
CREATE USER 'ME'@'localhost' IDENTIFIED BY 'password' WITH MAX_USER_CONNECTIONS 2;
CREATE USER 'ME'@'localhost' IDENTIFIED BY 'password' PASSWORD EXPIRE NEVER;

[СРОКИ ДЕЙСТВИЯ ПАРОЛЯ]
PASSWORD EXPIRE
PASSWORD EXPIRE NEVER
PASSWORD EXPIRE INTERVAL N DAY
PASSWORD HISTORY N
PASSWORD REUSE INTERVAL N DAY
PASSWORD REQUIRE CURRENT

GRANT [TYPE] ON [NAME_BD].[NAME_TABLE] TO 'ME'@'localhost';

[Права доступа]
ALL PRIVILEGES
CREATE
SELECT
INSERT
UPDATE
DELETE
DROP

FLUSH PRIVILEGES
REVOKE [TYPE] ON [NAME_BD].[NAME_TABLE] TO 'ME'@'localhost';
SHOW GRANTS user_name;

ALTER USER 'ME'@'localhost' IDENTIFIED BY 'newpassword';
ALTER USER 'ME'@'localhost' ACCOUNT LOCK;
ALTER USER 'ME'@'localhost' ACCOUNT UNLOCK;

RENAME USER 'ME'@'localhost' TO 'NEW_ME'@'localhost';
DROP USER IF EXISTS 'NEW_ME'@'localhost';

SELECT * FROM mysql.user;
SELECT * FROM mysql.db;
SELECT * FROM mysql.tables_priv;
SELECT * FROM mysql.columns_priv;
SELECT * FROM information_schema.user_privileges;

<!-- СОЗДАНИЕ ТАБЛИЦ -->
CREATE TABLE IF NOT EXISTS `dict_articles` (
`article_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`term` varCHAR(50) NOT NULL,
`part_speech` varCHAR(15) NOT NULL,
`definition` INT NOT NULL REFERENCES definitions(def_id));

CREATE TABLE IF NOT EXISTS `definitions` (
`def_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`def_name` varCHAR(500) NOT NULL);

CREATE TABLE IF NOT EXISTS `contexts` (
`cont_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`rus_cont`varCHAR(500) NOT NULL,
`eng_cont`varCHAR(500) NOT NULL,
`source` varCHAR(150) NOT NULL);

CREATE TABLE IF NOT EXISTS `dict_cont` (
`dict_cont_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`context` INT NOT NULL REFERENCES contexts(cont_id),
`article_forcont` INT NOT NULL REFERENCES dict_articles(article_id));

CREATE TABLE IF NOT EXISTS `translations` (
`transl_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`transl_name` varCHAR(50) NOT NULL,
`transcription` varCHAR(50) NOT NULL);

CREATE TABLE IF NOT EXISTS `dict_transl` (
`dict_transl_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`translation` INT NOT NULL REFERENCES translations(transl_id),
`article_fortransl` INT NOT NULL REFERENCES dict_articles(article_id));

<!-- ВВОД ДАННЫХ -->
INSERT INTO `dict_articles` VALUES
(1,"Вращательное движение", "словосочетание", 1),
(2,"Вектор", "существительное", 2),
(3,"Магнитное поле", "словосочетание",3),
(4,"МПЗ", "аббревиатура", 3),
(5,"Напряженность", "существительное", 4); 
INSERT INTO `definitions` VALUES
(1, "Вид механического движения, при котором материальная точка описывает окружность."),
(2, "Изображаемая отрезком прямой математическая величина, характеризующаяся численным значением и направлением."),
(3, "Поле, действующее на движущиеся электрические заряды и на тела, обладающие магнитным моментом, независимо от состояния их движения; магнитная составляющая электромагнитного поля."),
(4, "Напряжённость магни́тного по́ля — векторная физическая величина, равная разности векторов магнитной индукции B → {\vec {B}} и намагниченности M → {\vec {M}} в рассматриваемой точке. Обозначается символом H → {\vec {H}}.");
INSERT INTO `contexts` VALUES
(1, "Определение вращательного движения Малого Космического Аппарата Аист-2д по данным магнитных измерений", "Detection of the Rotational Motion of the AIST-2D Small Spacecraft
by Magnetic Measurements", "Абрашкин – Космические исследования – 2019"),
(2, "Приведены результаты реконструкции вращательного движения малого спутника Аист-2Д по данным бортовых измерений векторов угловой скорости и напряженности магнитного поля Земли (МПЗ), полученным летом 2016 г.", "The paper presents the reconstruction results of rotational motion of the AIST-2D small spacecraft by onboard measurements of vectors of angular velocity and the strength of Earth’s magnetic field obtained in summer 2016.", "Абрашкин – Космические исследования – 2019"),
(3, "Компоненты измеряемых векторов напряженности магнитного поля выдавались в собственных системах координат магнитометров.", "The components of the measured vectors of the magnetic field strength were output in intrinsic coordinate systems of magnetometers.", "Абрашкин – Космические исследования – 2019");
INSERT INTO `dict_cont` VALUES
(1, 1, 1),
(2, 2, 1),
(3, 2, 2),
(4, 2, 3),
(5, 3, 4),
(6, 3, 5);
INSERT INTO `translations` VALUES
(1, "Rotational motion", "rəʊˈteɪʃənəl ˈməʊʃ(ə)n"),
(2, "Vector", "ˈvektə"),
(3, "Magnetic field", "mæɡˈnetɪk fiːld"),
(4, "EMF", "i: em ef"),
(5, "Strength", "streŋkθ");
INSERT INTO `dict_transl` VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

<!--ТРИГГЕР `AFTER DELETE`-->
DELIMITER //
CREATE TRIGGER `ad_def`
AFTER DELETE
ON `definitions`
FOR EACH ROW
BEGIN
    DELETE FROM dict_articles WHERE dict_articles.article_id = OLD.def_id;
END//
DELIMITER;

<!-- ВЫБОРКА ПО ПАРАМЕТРАМ, УСЛОВИЯМ И ФИЛЬТРАМ -->
SELECT count(*) FROM `dict_articles`;
SELECT * FROM `dict_articles` WHERE term LIKE 'В%' ORDER BY term;
SELECT DISTINCT def_name FROM `definitions`;
SELECT term from dict_articles where definition in (select definition FROM dict_articles GROUP BY definition HAVING COUNT(*)>1);
SELECT dict_articles.term, translations.transl_name from dict_articles, translations, dict_transl where translations.transl_id = dict_transl.translation AND dict_articles.article_id = dict_transl.article_fortransl;
SELECT term, rus_cont FROM dict_cont 
LEFT OUTER JOIN dict_articles ON article_forcont=article_id 
left outer join contexts on  context=cont_id where term = "Вращательное движение";

<!--ИЗМЕНЕНИЕ СТРУКТУРЫ ТАБЛИЦ-->
UPDATE `dict_articles` SET term="Магнитное поле Земли" where term="Магнитное поле";
ALTER TABLE dict_articles ADD INDEX `ix_term` (`term`);
ALTER TABLE contexts ADD INDEX `ix_cont` (`rus_cont`, `eng_cont`);
ALTER TABLE contexts DROP INDEX `rus_cont`, `eng_cont`;


<!--CREATING_VIEW-->
CREATE VIEW full_article AS SELECT dict_articles.article_id, dict_articles.term, dict_articles.part_speech, definitions.def_name, translations.transl_name, translations.transcription, contexts.rus_cont, contexts.eng_cont, contexts.source FROM dict_articles, definitions, translations, contexts, dict_cont, dict_transl WHERE dict_articles.definition = definitions.def_id AND contexts.cont_id = dict_cont.context AND dict_articles.article_id = dict_cont.article_forcont AND translations.transl_id = dict_transl.translation AND dict_articles.article_id = dict_transl.article_fortransl;








<!--ТРИГГЕР `BEFORE DELETE`-->
DELIMITER //
CREATE TRIGGER bd_test
BEFORE DELETE
ON dict_articles
FOR EACH ROW
    SET MESSAGE_TEXT = 'Вы удалили данные, проверьте связи с таблицами';
END IF//
DELIMITER;

<!--ТРИГГЕР `AFTER UPDATE`-->
DELIMITER //
CREATE TRIGGER `ai_term`
BEFORE INSERT
ON `dict_articles`
FOR EACH ROW
    SET MESSAGE_TEXT = 'Вы обновили данные';
END IF//
DELIMITER;

<!--ТРИГГЕРЫ ТАБЛИЦ-->
<!--АУДИТ-->
CREATE TABLE `Audit`(
`Id_audit` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`Tbl_name` varCHAR(60) NOT NULL,
`Tbl_id` INT NOT NULL,
`Date` DATETIME NOT NULL,
`Operation` varCHAR NOT NULL);

<!--ТРИГГЕР `BEFORE INSERT`-->
DELIMITER //
CREATE TRIGGER `bi_test`
BEFORE INSERT
ON `Test`
FOR EACH ROW
IF NEW.test_category>5 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'AAAAAA >5';
END IF//
DELIMITER;

<!--ТРИГГЕР `BEFORE UPDATE`-->
DELIMITER //
CREATE TRIGGER `bu_test`
BEFORE INSERT
ON `Test`
FOR EACH ROW
IF OLD.test_category=5 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'CANNOT BE UPDATED';
END IF//
DELIMITER;



<!--ТРИГГЕР `AFTER INSERT`-->
DELIMITER //
CREATE TRIGGER `ai_test`
BEFORE INSERT
ON `Test`
FOR EACH ROW
    INSERT INTO `Audit` (`Id`, `Tbl_name`, `Tbl_id`, `Date`, `Operation`) VALUES ('', 'TEST', NEW.test_id, NOW(), 'insert');
END IF//
DELIMITER;


SELECT * FROM `Audit`;

DROP TRIGGER IF EXISTS `ai_test`;

<!--УДАЛЕНИЕ СТРУКТУРЫ ИЛИ ТАБЛИЦ-->
ALTER TABLE `Client`
DROP COLUMN age;

<!--ИНДЕКС-->
ALTER TABLE `Test` ADD INDEX `index_test` (`test_brand`); <!--напр, номера заказов-->

<!--УНИКАЛЬНЫЙ ИНДЕКС-->
ALTER TABLE `Test` ADD UNIQUE (`test_brand`);

<!--СОСТАВНОЙ ИНДЕКС-->
ALTER TABLE `Test` ADD INDEX `ix_two_test` (`test_brand`, `test_category`);

<!--УДАЛЕНИЕ ИНДЕКСА-->
ALTER TABLE `Test` DROP INDEX `test_brand`, `test_category`;
ALTER TABLE `Test` DROP INDEX `test_brand`;

ALTER TABLE `Test`
DROP PRIMARY KEY;
ALTER TABLE `Test`
ADD PRIMARY KEY (test_id);

ALTER TABLE `Test`
ADD FOREIGN KEY (ID) REFERENCES Contract(contract_id);

<!--ОБНОВЛЕНИЕ ДАННЫХ ТАБЛИЦ-->
UPDATE `Test`
SET test_category = test_category+1;

UPDATE `Test`
SET test_brand ="ROSA HOTEL"
WHERE test_brand = "TESSTSTTST";

UPDATE `Test`
SET test_category = DEFAULT
WHERE test_category = 2;

<!--ИЗМЕНЕНИЕ СТРУКТУРЫ ТАБЛИЦ-->
ALTER TABLE `Test`
ADD age INT(100) not null;

ALTER TABLE `Test`
MODIFY COLUMN age INT(125) NOT NULL;

ALTER TABLE `Test` 
ALTER COLUMN test_category SET DEFAULT 5;


