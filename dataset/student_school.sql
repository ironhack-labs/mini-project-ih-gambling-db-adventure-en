CREATE TABLE IF NOT EXISTS `student_school` (
    `Table_student` VARCHAR(11) CHARACTER SET utf8,
    `Column_2` VARCHAR(12) CHARACTER SET utf8,
    `Column_3` VARCHAR(13) CHARACTER SET utf8,
    `Column_4` VARCHAR(11) CHARACTER SET utf8,
    `Column_5` VARCHAR(9) CHARACTER SET utf8,
    `Column_6` INT,
    `Column_7` INT,
    `Table_school` VARCHAR(11) CHARACTER SET utf8,
    `Column_9` VARCHAR(25) CHARACTER SET utf8,
    `Column_10` VARCHAR(13) CHARACTER SET utf8
);
INSERT INTO `student_school` VALUES ('student_id','student_name','city','school_id','GPA',NULL,NULL,'school_id','school_name','city'),
	('-----------','------------','----------','-----------','---------',NULL,NULL,'-----------','------------------','----------'),
	('1001','Peter Brebec','New York','1','4',NULL,NULL,'1','Stanford','Stanford'),
	('1002','John Goorgy','San Francisco','2','3,1',NULL,NULL,'2','University of California','San Francisco'),
	('2003','Brad Smith','New York','3','2,9',NULL,NULL,'3','Harvard University','New York'),
	('1004','Fabian Johns','Boston','5','2,1',NULL,NULL,'4','MIT','Boston'),
	('1005','Brad Cameron','Stanford','1','2,3',NULL,NULL,'5','Yale','New Haven'),
	('1006','Geoff Firby','Boston','5','1,2',NULL,NULL,'6','University of Westminster','London'),
	('1007','Johnny Blue','New Haven','2','3,8',NULL,NULL,'7','Corvinus University','Budapest'),
	('1008','Johse Brook','Miami','2','3,4',NULL,NULL,NULL,NULL,NULL);
