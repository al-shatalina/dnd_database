

<!-- СОЗДАНИЕ ТАБЛИЦ -->
CREATE TABLE IF NOT EXISTS `regions` (
`region` VARCHAR(300) NOT NULL PRIMARY KEY);

CREATE TABLE IF NOT EXISTS `places` (
`place` VARCHAR(300) NOT NULL PRIMARY KEY,
`place_region` VARCHAR(300) REFERENCES regions(region));

CREATE TABLE IF NOT EXISTS `planned_events` (
`event_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`event_name` varCHAR(300),
`planned_session_number` INT NOT NULL,
`is_battle` BOOLEAN NOT NULL,
`event_place` VARCHAR(300) REFERENCES places(place),
`event_description` TEXT);

CREATE TABLE IF NOT EXISTS `alignment_part1` (
`alignment1_name` VARCHAR(100) NOT NULL PRIMARY KEY);

CREATE TABLE IF NOT EXISTS `alignment_part2` (
`alignment2_name` VARCHAR(100) NOT NULL PRIMARY KEY);

CREATE TABLE IF NOT EXISTS `material_components` (
`material_name` VARCHAR(200) NOT NULL PRIMARY KEY);

CREATE TABLE IF NOT EXISTS `casting_times`(
`cast_time` VARCHAR(100) NOT NULL PRIMARY KEY);

CREATE TABLE IF NOT EXISTS `spells_and_features` (
`sf_name` VARCHAR(300) NOT NULL PRIMARY KEY,
`verbal` BOOLEAN NOT NULL,
`somatic` BOOLEAN NOT NULL,
`material` BOOLEAN NOT NULL,
`casting_time` VARCHAR(100) REFERENCES casting_times(cast_time),
`duration` INT,
`range` INT,
`sf_description` TEXT);

CREATE TABLE IF NOT EXISTS `spell_materials` (
`spell_materials_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`spell_material` VARCHAR(200) REFERENCES spells_and_features(sf_name),
`material_spell` VARCHAR(200) REFERENCES material_components(material_name));

CREATE TABLE IF NOT EXISTS `classes` (
`class` VARCHAR(200) NOT NULL PRIMARY KEY);

CREATE TABLE IF NOT EXISTS `races` (
`race` VARCHAR(200) NOT NULL PRIMARY KEY);

CREATE TABLE IF NOT EXISTS `class_spells` (
`class_spells_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`class_spell` VARCHAR(200) REFERENCES classes(class),
`spell_class` VARCHAR(200) REFERENCES spells_and_features(sf_name));

CREATE TABLE IF NOT EXISTS `race_spells` (
`race_spells_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`race_spell` VARCHAR(200) REFERENCES races(race),
`spell_race` VARCHAR(200) REFERENCES spells_and_features(sf_name));

CREATE TABLE IF NOT EXISTS `characters` (
`char_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`char_name` VARCHAR(300) NOT NULL,
`char_surname` VARCHAR(300),
`playability` BOOLEAN NOT NULL,
`alive` BOOLEAN NOT NULL,
`char_level` INT NOT NULL,
`char_armour` INT NOT NULL,
`speed` INT NOT NULL,
`char_race` VARCHAR(200) REFERENCES races(race),
`total_hp` INT NOT NULL,
`char_description` TEXT,
`char_alignment1` VARCHAR(100) REFERENCES alignment_part1(alignment1_name),
`char_alignment2` VARCHAR(100) REFERENCES alignment_part2(alignment2_name));

CREATE TABLE IF NOT EXISTS `char_stats`(
`char_stat_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`char_stat` INT NOT NULL REFERENCES characters(char_id),
`stat_char` VARCHAR(100) NOT NULL REFERENCES stats(stat),
`ability_score` INT
);

CREATE TABLE IF NOT EXISTS `stats` (
`stat` VARCHAR(100) NOT NULL PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS `char_classes` (
`char_classes_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`char_class` INT NOT NULL REFERENCES characters(character_id),
`class_char` VARCHAR(200) REFERENCES classes(class));

CREATE TABLE IF NOT EXISTS `char_spells` (
`char_spells_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`char_spell` VARCHAR(200) REFERENCES characters(char_id),
`spell_char` VARCHAR(200) REFERENCES spells_and_features(sf_name));

CREATE TABLE IF NOT EXISTS `actual_events` (
`actual_events_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
`actual_session_number` INT NOT NULL,
`event` INT REFERENCES planned_events(event_id),
`event_char` VARCHAR(300) REFERENCES characters(char_id),
`char_action` TEXT NOT NULL);

<!-- ВЫБОРКА ПО ПАРАМЕТРАМ, УСЛОВИЯМ И ФИЛЬТРАМ -->

<--CRUD +0.5
--WHERE С ОБЪЕДИНЕНИЕМ 3 ТАБЛИЦ + 0.4
--ВЛОЖЕННЫЙ + 0.3 
--WITH + 0.2
--JOIN + 0.5
--LEFT/RIGHT JOIN + 0.5??
--GROUP BY + 0.1
--ORDER BY + 0.2
--АГГРЕГАЦИЯ В РЕЗУЛЬТАТЕ 0.2
--HAVING + 0.3
--ТРИГГЕРЫ + 0.5
--ПРОЦЕДУРЫ + 0.4
--ВЫЗОВ ПРОЦЕДУРЫ + 0.1
--ВНЕШНИЕ КЛЮЧИ + 0.2
--ИНДЕКСЫ + 0.2
--КРАСОТА РЕШЕНИЯ ? 0.6
--SQL БАЗА + 1
--СКРИПТ С ПОДКЛЮЧЕНИЕМ +? 0.2
--СКРИПТ С ИСТОРИЕЙ +? 0.8
--БАЗА В КОНТЕЙНЕРЕ + 0.5
--DOCKER COMPOSE + 0.5
--WINDOW FUNCTIONS + 0.5  -->

<--?index-->
ALTER TABLE `characters` ADD INDEX `ix_char_full_name` (`char_name`, `char_surname`);

<--?UPDATE-->
UPDATE `characters`
SET char_surname = 'Bugbearov'
WHERE char_name = 'Bugbear';

UPDATE `characters`
SET char_surname = 'Goblinov'
WHERE char_name = 'Goblin';

<!--ТРИГГЕР `AFTER DELETE`-->
DELIMITER //
CREATE TRIGGER `ad_regions`
AFTER DELETE
ON `regions`
FOR EACH ROW
BEGIN
    DELETE FROM places WHERE places.place_region = OLD.region;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER `ad_planned_events`
AFTER DELETE
ON `places`
FOR EACH ROW
BEGIN
    DELETE FROM planned_events WHERE planned_events.event_place = OLD.place;
END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER `ad_actual_events`
AFTER DELETE
ON `planned_events`
FOR EACH ROW
BEGIN
    DELETE FROM actual_events WHERE actual_events.event = OLD.event_id;
END//
DELIMITER ;

DELETE FROM `regions` WHERE region = 'Neverwinter';

<--?Выбор информации о персонажах только Lawful--> 
SELECT COUNT(*), char_alignment1, char_alignment2
FROM characters 
GROUP BY char_alignment1, char_alignment2;

<--Выбор заклинаний и умений конкретного персонажа-->

SELECT spells_and_features.sf_name, spells_and_features.sf_description 
FROM spells_and_features, char_spells, characters 
WHERE char_spells.char_spell=characters.char_id AND char_spells.spell_char=spells_and_features.sf_name 
AND characters.char_id = 1;

<--Выбор только фичей-->
CREATE VIEW `features` AS
SELECT sf_name, sf_description, class_spell FROM spells_and_features
RIGHT JOIN class_spells ON spell_class = sf_name
WHERE somatic = FALSE AND verbal = FALSE AND material = FALSE;

<--Выбор только заклинаний-->
CREATE VIEW `spells` AS
SELECT sf_name,verbal, somatic, material, casting_time, duration, spells_and_features.range, sf_description, class_spell
FROM spells_and_features
RIGHT JOIN class_spells ON spell_class = sf_name
WHERE somatic = TRUE OR verbal = TRUE OR material = TRUE;

<--Запрос с group by-->
SELECT char_race, AVG(total_hp) from characters
group by char_race
having AVG(total_hp) > 50;

<--Только заклинания игровых персонажей-->
WITH pc_spells_features AS 
(SELECT characters.char_name, char_spells.spell_char
FROM char_spells, characters 
WHERE char_spells.char_spell=characters.char_id AND characters.playability=TRUE
ORDER BY characters.char_name)

SELECT char_name, sf_name, sf_description, class_spell
FROM pc_spells_features
JOIN spells_and_features ON spell_char = sf_name
WHERE sf_name IN (SELECT sf_name FROM spells);

<--БЕЗ WITH-->

SELECT char_name, spell_char, sf_name, sf_description, class_spell
FROM char_spells, characters
JOIN spells_and_features ON spell_char = sf_name
WHERE sf_name IN (SELECT sf_name FROM spells) AND char_spells.char_spell=characters.char_id AND characters.playability=TRUE
ORDER BY characters.char_name;

<--?Вывести материальные компоненты для заклинаний-->
SELECT material_spell, spell_material FROM spell_materials ORDER BY spell_material

<--WINDOW FUNCTION AVG (attributes)-->
WITH window_avg_score AS(
    SELECT char_stat, stat_char, ability_score,
    AVG(ability_score) OVER
    (PARTITION BY char_stat) AS ability_score_avg
    FROM char_stats)
SELECT DISTINCT char_name, char_surname, ability_score_avg FROM window_avg_score
JOIN characters ON char_id = char_stat;

<--WINDOW FUNCTION MAX (attributes)-->
WITH window_max_score AS(
    SELECT char_stat, stat_char, ability_score,
    MAX(ability_score) OVER
    (PARTITION BY char_stat) AS ability_score_max
    FROM char_stats)
SELECT DISTINCT char_name, char_surname, ability_score_max FROM window_max_score
JOIN characters ON char_id = char_stat;

<--?Procedures-->

DELIMITER //

CREATE PROCEDURE SelectAbilities(IN charname VARCHAR(300), IN charsurname VARCHAR(300))
BEGIN
    SELECT char_name, char_surname, stat_char, ability_score
    FROM char_stats
    LEFT JOIN characters ON char_id = char_stat
    WHERE char_name = charname AND char_surname = charsurname;
END //

DELIMITER ;

CALL SelectAbilities('Elara', 'Moonshadow');

<!--ТРИГГЕР `BEFORE UPDATE`--> не работает :)
DELIMITER //
CREATE TRIGGER `bu_char_spells`
BEFORE UPDATE
ON `char_spells`
FOR EACH ROW
BEGIN
    DECLARE charac INT;
    DECLARE class VARCHAR(200);
    DECLARE class_spell VARCHAR(200);

    SELECT char_id FROM characters INTO charac
    WHERE char_id = NEW.char_spell;

    SELECT class_char FROM char_classes INTO class
    WHERE char_class = NEW.char_spell;

    SELECT class_spell FROM class_spells INTO class_spell
    WHERE spell_class = NEW.spell_char;

    IF (class_spell != class) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'AAAAAA';
END IF//  
DELIMITER ;
