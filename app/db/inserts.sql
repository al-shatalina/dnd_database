<!-- ВВОД ДАННЫХ -->
INSERT INTO `alignment_part1` VALUES
('lawful'),
('neutral'),
('chaotic');

INSERT INTO `alignment_part2` VALUES
('good'),
('neutral'),
('evil');

INSERT INTO `material_components` VALUES
('Sulfur'),
('Ash'),
('Powdered Ruby'),
('Leather'),
('Glass'),
('Powdered Silver');

INSERT INTO `casting_times` VALUES
('Action'),
('Bonus action'),
('Reaction'),
('Passive');

<--DONE-->

INSERT INTO `spell_materials` VALUES
(1, 'Fireball', 'Sulfur'),
(2, 'Fireball', 'Ash'),
(3, 'Arcane Eye', 'Powdered Ruby'),
(4, 'Lightning Bolt', 'Sulfur'),
(5, 'Lightning Bolt', 'Glass'),
(6, 'Mage Armor', 'Leather'),
(7, 'Mage Armor', 'Glass'),
(8, 'Invisibility', 'Powdered Silver');

INSERT INTO `spells_and_features` VALUES
('Cure Wounds', TRUE, TRUE, FALSE, 'Action', 0, 0, 'You cure 1d4 hitpoints of a creature you touch'),
('Fireball', TRUE, TRUE, TRUE, 'Action', 0, 150, 'A bright streak flashes from your pointing finger to a point you choose within range and then blossoms with a low roar into an explosion of flame.'),
('Arcane Eye', TRUE, FALSE, TRUE, 'Action', -1, 30, 'You create an invisible, magical eye that hovers in the air for the duration.'),
('Teleport', TRUE, FALSE, FALSE, 'Action', -1, 0, 'You and up to eight willing creatures teleport to a destination you specify.'),
('Shield', TRUE, TRUE, FALSE, 'Reaction', 1, 0, 'An invisible barrier of magical force appears and protects you.'),
('Great Weapon Master', FALSE, FALSE, FALSE, 'Bonus Action', 0, 0, 'You can take a -5 penalty to your attack roll to gain a +10 bonus to damage.'),
('Second Wind', FALSE, FALSE, FALSE, 'Bonus Action', 0, 0, 'You can regain hit points equal to 1d10 + your fighter level.'),
('Action Surge', FALSE, FALSE, FALSE, 'Action', 0, 0, 'You can take one additional action on your turn.'),
('Sneak Attack', FALSE, FALSE, FALSE, 'Action', 0, 0, 'You deal extra damage when you hit a creature with a ranged or finesse weapon.'),
('Cunning Action', FALSE, FALSE, FALSE, 'Bonus Action', 0, 0, 'You can take the Dash, Disengage, or Hide action as a bonus action.'),
('Regeneration', FALSE, FALSE, FALSE, 'Action', -1, 0, 'You regain hit points at the start of your turn.'),
('Multiattack', FALSE, FALSE, FALSE, 'Action', 0, 0, 'You can make multiple attacks in one action.'),
('Lightning Bolt', TRUE, TRUE, TRUE, 'Action', 0, 100, 'A stroke of lightning forming a line 100 feet long and 5 feet wide blasts out from you.'),
('Thunderwave', TRUE, TRUE, FALSE, 'Action', 3, 15, 'A wave of thunderous force sweeps out from you. Each creature in a 15-foot cube originating from you must make a Constitution saving throw.'),
('Mage Armor', TRUE, FALSE, TRUE, 'Action', 1, 0, 'You touch a willing creature who isn’t wearing armor, and a protective magical force surrounds it until the spell ends.'),
('Backstab', FALSE, FALSE, FALSE, 'Action', 0, 0, 'You deal extra damage when you hit a creature that is surprised.'),
('Evasion', FALSE, FALSE, FALSE, 'Passive', 0, 0, 'You can dodge out of the way of certain area effects.'),
('Invisibility', TRUE, TRUE, TRUE, 'Action', -1, 0, 'A creature you touch becomes invisible until the spell ends. Anything the target is wearing or carrying is invisible as long as it is on the target’s person.'),
('Rage', FALSE, FALSE, FALSE, 'Bonus Action', 1, 0, 'You enter a rage that lasts for 1 minute, gaining various benefits.'),
('Reckless Attack', FALSE, FALSE, FALSE, 'Action', 0, 0, 'You can choose to attack recklessly, gaining advantage on melee attack rolls.'),
('Divine Smite', FALSE, FALSE, FALSE, 'Bonus Action', 0, 0, 'When you hit a creature with a melee weapon attack, you can expend one spell slot to deal radiant damage.'),
('Lay on Hands', FALSE, FALSE, FALSE, 'Action', 0, 0, 'You can restore a total number of hit points equal to your paladin level.'),
('Aura of Protection', FALSE, FALSE, FALSE, 'Passive', 0, 0, 'You and friendly creatures within 10 feet of you gain a bonus to saving throws.'),
('Luck', FALSE, FALSE, FALSE, 'Passive', 0, 0, 'You can reroll a failed saving throw or attack roll.'),
('Hellish Rebuke', TRUE, TRUE, TRUE, 'Passive', 0, 60, 'You can retaliate against an attacker with flames.'),
('Relentless Endurance', FALSE, FALSE, FALSE, 'Passive', 0, 0, 'You can drop to 1 hit point instead of 0 once per long rest.'),
('Fey Ancestry', FALSE, FALSE, FALSE, 'Passive', 0, 0, 'You have advantage on saving throws against being charmed.'),
('Healing Hands', TRUE, FALSE, FALSE, 'Action', 0, 0, 'You can heal a creature by touching them, restoring hit points equal to their level.'),
('Feline Agility', FALSE, FALSE, FALSE, 'Passive', 0, 0, 'You can move with incredible speed and agility for a short time.'),
('Elemental Affinity', TRUE, FALSE, TRUE, 'Action', 0, 0, 'You can add their proficiency bonus to damage rolls of spells that match their elemental type.'),
("Stone's Endurance", FALSE, FALSE, FALSE, 'Reaction', 0, 0, 'You can reduce damage taken by rolling a d12 and adding their Constitution modifier.'),
('Pack Tactics', FALSE, FALSE, FALSE, 'Passive', 0, 0, 'You have advantage on attack rolls against a creature if at least one of their allies is within 5 feet of the creature.');

<--CLASSES DONE-->
INSERT INTO `classes` VALUES
('Artificer'),
('Barbarian'),
('Bard'),
('Cleric'),
('Druid'),
('Fighter'),
('Monk'),
('Paladin'),
('Ranger'),
('Rogue'),
('Sorcerer'),
('Warlock'),
('Wizard');

INSERT INTO `class_spells` VALUES
(1, 'Wizard', 'Fireball'),
(2, 'Wizard', 'Arcane Eye'),
(3, 'Wizard', 'Teleport'),
(4, 'Wizard', 'Shield'),
(5, 'Fighter', 'Great Weapon Master'),
(6, 'Fighter', 'Second Wind'),
(7, 'Fighter', 'Action Surge'),
(8, 'Rogue', 'Sneak Attack'),
(9, 'Rogue', 'Cunning Action'),
(10, 'Druid', 'Regeneration'),
(11, 'Druid', 'Multiattack'),
(12, 'Sorcerer', 'Lightning Bolt'),
(13, 'Sorcerer', 'Thunderwave'),
(14, 'Sorcerer', 'Mage Armor'),
(15, 'Rogue', 'Backstab'),
(16, 'Rogue', 'Evasion'),
(17, 'Rogue', 'Invisibility'),
(18, 'Barbarian', 'Rage'),
(19, 'Barbarian', 'Reckless Attack'),
(20, 'Paladin', 'Divine Smite'),
(21, 'Paladin', 'Lay on Hands'),
(22, 'Paladin', 'Aura of Protection'),
(23, 'Cleric', 'Cure Wounds');

INSERT INTO `race_spells` VALUES
(1, 'Halfling', 'Luck'),
(2, 'Tiefling', 'Hellish Rebuke'),
(3, 'Half-Orc', 'Relentless Endurance'),
(4, 'Elf', 'Fey Ancestry'),
(5, 'Aasimar', 'Healing Hands'),
(6, 'Tabaxi', 'Feline Agility'),
(7, 'Genasi', 'Elemental Affinity'),
(8, 'Goliath', "Stone's Endurance"),
(9, 'Kobald', 'Pack Tactics');

<--RACES DONE-->
INSERT INTO `races` VALUES
('Human'), ('Elf'), ('Dwarf'), ('Orc'), ('Halfling'), ('Goblin'), ('Dragonborn'),
('Lizardfolk'), ('Genasi'), ('Goliath'), ('Gnome'), ('Hobgoblin'), ('Firbolg'),
('Yuan-Ti'), ('Tabaxi'), ('Kobald'), ('Triton'), ('Tortle'), ('Shifter'),
('Centaur'), ('Minotaur'), ('Aarakocra'), ('Kenku'), ('Satyr'), ('Bugbear'),
('Kalashtar'), ('Changeling'), ('Loxodon'), ('Tiefling'), ('Aasimar');

INSERT INTO `characters` VALUES
(1, 'Elara', 'Moonshadow', FALSE, TRUE, 5, 12, 30, 'Elf', 30, 'A wise elf with a deep connection to the arcane, Elara is known for her vast knowledge of ancient spells.', 'Neutral', 'Good'),
(2, 'Thrain', 'Ironfist', FALSE, FALSE, 4, 16, 25, 'Dwarf', 40, 'A stout dwarf with a fierce demeanor, Thrain is a master of the battle axe and a loyal friend.', 'Lawful', 'Good'),
(3, 'Goblin', NULL, FALSE, FALSE, 1, 15, 30, 'Goblin', 7, 'A small, cunning creature that thrives in packs, often raiding travelers for supplies.', 'Chaotic', 'Neutral'),
(4, 'Bugbear', NULL, FALSE, TRUE, 6, 14, 30, 'Bugbear', 84, 'A hulking creature that lurks in the shadows of the forest, known for its regenerative abilities.', 'Chaotic', 'Evil'),
(5, 'Kael', 'Stormrider', TRUE, TRUE, 14, 15, 30, 'Human', 100, 'A powerful sorcerer with a mysterious past, Kael commands the storms and wields lightning with ease.', 'Chaotic', 'Good'),
(6, 'Thalia', 'Shadowblade', TRUE, TRUE, 15, 14, 35, 'Elf', 90, 'A cunning rogue who moves like a shadow, Thalia is known for her agility and deadly precision.', 'Neutral', 'Evil'),
(7, 'Grom', 'Ironhide', TRUE, TRUE, 16, 17, 30, 'Orc', 120, 'A fierce barbarian with unmatched strength, Grom charges into battle with a primal rage.', 'Chaotic', 'Neutral'),
(8, 'Seraphine', 'Lightbringer', TRUE, TRUE, 17, 20, 30, 'Aasimar', 110, 'A noble paladin dedicated to the light, Seraphine fights for justice and protects the innocent.', 'Lawful', 'Good');

insert into `stats` VALUES 
('strength'),
('dexterity'),
('constitution'),
('charisma'),
('wisdom'),
('intelligence');

INSERT INTO `char_stats` VALUES
(1, 1, 'strength', 8), 
(2, 1, 'dexterity', 14),
(3, 1, 'constitution', 12),
(4, 1, 'charisma', 16),
(5, 1, 'wisdom', 15),
(6, 1, 'intelligence', 18),

(7, 2, 'strength', 18),
(8, 2, 'dexterity', 10),
(9, 2, 'constitution', 16),
(10, 2, 'charisma', 10),
(11, 2, 'wisdom', 12),
(12, 2, 'intelligence', 8),

(13, 3, 'strength', 10),
(14, 3, 'dexterity', 14),
(15, 3, 'constitution', 10),
(16, 3, 'charisma', 8),
(17, 3, 'wisdom', 10),
(18, 3, 'intelligence', 10),

(19, 4, 'strength', 20),
(20, 4, 'dexterity', 12),
(21, 4, 'constitution', 18),
(22, 4, 'charisma', 6),
(23, 4, 'wisdom', 10),
(24, 4, 'intelligence', 5),

(25, 5, 'strength', 10),
(26, 5, 'dexterity', 14),
(27, 5, 'constitution', 12),
(28, 5, 'charisma', 18),
(29, 5, 'wisdom', 16),
(30, 5, 'intelligence', 14),

(31, 6, 'strength', 8),
(32, 6, 'dexterity', 18),
(33, 6, 'constitution', 12),
(34, 6, 'charisma', 14),
(35, 6, 'wisdom', 10),
(36, 6, 'intelligence', 16),

(37, 7, 'strength', 20),
(38, 7, 'dexterity', 12),
(39, 7, 'constitution', 18),
(40, 7, 'charisma', 8),
(41, 7, 'wisdom', 10),
(42, 7, 'intelligence', 10),

(43, 8, 'strength', 16),
(44, 8, 'dexterity', 14),
(45, 8, 'constitution', 16),
(46, 8, 'charisma', 18),
(47, 8, 'wisdom', 20),
(48, 8, 'intelligence', 12);

INSERT INTO `char_classes` VALUES 
(1, 1, 'Wizard'),  -- Elara Moonshadow
(2, 2, 'Fighter'),  -- Thrain Ironfist
(3, 5, 'Sorcerer'), -- Kael Stormrider
(4, 6, 'Rogue'), -- Thalia Shadowblade
(5, 7, 'Barbarian'),  -- Grom Ironhide
(6, 8, 'Paladin'), -- Seraphine Lightbringer
(7, 8, 'Cleric'); -- Seraphine Lightbringer

INSERT INTO `char_spells` VALUES 
(1, 1, 'Fireball'),  -- Elara Moonshadow
(2, 1, 'Arcane Eye'),
(3, 1, 'Teleport'),
(4, 1, 'Shield'),
(5, 1, 'Fey Ancestry'),

(6, 2, 'Great Weapon Master'),  -- Thrain Ironfist
(7, 2, 'Second Wind'),
(8, 2, 'Action Surge'),

(9, 3, 'Sneak Attack'),  -- Goblin Raider
(10, 3, 'Cunning Action'),

(11, 4, 'Regeneration'),  -- Forest Troll
(12, 4, 'Multiattack'),

(13, 5, 'Lightning Bolt'),  -- Kael Stormrider
(14, 5, 'Thunderwave'),
(15, 5, 'Mage Armor'),

(16, 6, 'Backstab'),  -- Thalia Shadowblade
(17, 6, 'Evasion'),
(18, 6, 'Invisibility'),

(19, 7, 'Rage'),  -- Grom Ironhide
(20, 7, 'Reckless Attack'),

(21, 8, 'Divine Smite'),  -- Seraphine Lightbringer
(22, 8, 'Lay on Hands'),
(23, 8, 'Aura of Protection'),
(24, 8, 'Cure Wounds'),
(25, 8, 'Healing Hands');

INSERT INTO `regions` VALUES
('Neverwinter'),
('Luskan');

INSERT INTO `places` VALUES
('Neverwinter Woods', 'Neverwinter'),
('Tower of Arcane', 'Luskan'),
('Demon Caves Dungeon', 'Luskan');

INSERT INTO `planned_events` VALUES
(1, 1, 'Ambush in the Neverwinter Woods', TRUE, 'Neverwinter Woods', 'An ambush, attackers determined by rolling a d4 on an encounter table'),
(2, 1, 'A broken carriage', FALSE, 'Neverwinter Woods', 'The party stumbles upon a destroyed caravan that was carrying goods (they will find spell components)'),
(3, 2, 'Negotiations with the Arcane Brotherhood', FALSE, 'Tower of Arcane', "The Brotherhood asks the party for help because of a demon threat."),
(4, 2, 'Battle for the Tower of Arcane', TRUE, 'Demon Caves Dungeon', "The demons strike. The party has to clear out a dungeon full of demons. The last room is filled with FLAMMABLE ensnaring roots.");

INSERT INTO `actual_events` VALUES
(1, 1, 1, 6, "Countered the ambush with her own ambush, by sneaking from behind"),
(2, 1, 1, 7, "Killed the barely alive attackers within one turn"),
(3, 2, 2, 8, "Pushed the party to investigate, and secured the components for Fireball"),
(4, 2, 2, 1, "Used a Fireball to light the roots on fire, as expected. Uncovered the hidden traps underneath :)");
