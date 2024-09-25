CREATE TABLE IF NOT EXISTS `account` (
    `AccountNo` VARCHAR(10) CHARACTER SET utf8,
    `CustId` INT,
    `AccountLocation` VARCHAR(3) CHARACTER SET utf8,
    `CurrencyCode` VARCHAR(3) CHARACTER SET utf8,
    `DailyDepositLimit` INT,
    `StakeScale` INT,
    `SourceProd` VARCHAR(2) CHARACTER SET utf8
);
INSERT INTO `account` VALUES ('00357DG   ',3531845,'GIB','GBP',0,1,'GM'),
	('00497XG   ',4188499,'GIB','GBP',0,1,'SB'),
	('00692VS   ',4704925,'GIB','USD',0,2,'SB'),
	('00775SM   ',2815836,'GIB','USD',0,1,'SB'),
	('00C017    ',889782,'GIB','GBP',1500,041,'XX'),
	('00J381    ',1191874,'GIB','GBP',500,8,'XX'),
	('01148BP   ',1569944,'GIB','GBP',0,8,'XX'),
	('01152SJ   ',1965214,'GIB','USD',0,1,'PO'),
	('01196ZZ   ',3042166,'GIB','EUR',0,8,'SB'),
	('01284UW   ',5694730,'GIB','GBP',0,1,'SB');
