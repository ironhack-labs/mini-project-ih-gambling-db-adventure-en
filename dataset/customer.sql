CREATE TABLE IF NOT EXISTS `customer` (
    `CustId` INT,
    `AccountLocation` VARCHAR(3) CHARACTER SET utf8,
    `Title` VARCHAR(4) CHARACTER SET utf8,
    `FirstName` VARCHAR(6) CHARACTER SET utf8,
    `LastName` VARCHAR(8) CHARACTER SET utf8,
    `CreateDate` DATETIME,
    `CountryCode` VARCHAR(3) CHARACTER SET utf8,
    `Language` VARCHAR(2) CHARACTER SET utf8,
    `Status` VARCHAR(1) CHARACTER SET utf8,
    `DateOfBirth` DATETIME,
    `Contact` VARCHAR(1) CHARACTER SET utf8,
    `CustomerGroup` VARCHAR(6) CHARACTER SET utf8
);
INSERT INTO `customer` VALUES (4188499,'GIB','Mr','Elvis','Presley','2011-11-01 00:00:00','US','en','A','1948-10-18 00:00:00','Y','Bronze'),
	(1191874,'GIB','Mr','Jim','Morrison','2008-09-19 00:00:00','US','en','A','1967-07-27 00:00:00','Y','Gold'),
	(3042166,'GIB','Mr','Keith','Moon','2011-01-11 00:00:00','UK ','en','A','1970-07-26 00:00:00','Y','Gold'),
	(5694730,'GIB','Mr','James','Hendrix','2012-10-10 00:00:00','US','en','A','1976-04-05 00:00:00','N','Bronze'),
	(4704925,'GIB','Mr','Marc','Bolan','2012-03-26 00:00:00','UK ','en','A','1982-03-11 00:00:00','Y','Bronze'),
	(1569944,'GIB','Miss','Janice','Joplin','2009-04-09 00:00:00','US','en','A','1954-08-22 00:00:00','Y','Gold'),
	(3531845,'GIB','Mr','Bon','Scott','2011-04-02 00:00:00','AU','en','A','1975-10-22 00:00:00','N','Silver'),
	(2815836,'GIB','Mr','Buddy','Holly','2010-10-17 00:00:00','US','en','A','1964-01-13 00:00:00','Y','Silver'),
	(889782,'GIB','Mr','Bob','Marley','2008-01-16 00:00:00','UK ','en','A','1964-04-18 00:00:00','Y','Silver'),
	(1965214,'GIB','Mr','Sidney','Vicious','2009-12-18 00:00:00','UK ','en','A','1976-08-12 00:00:00','N','Bronze');
