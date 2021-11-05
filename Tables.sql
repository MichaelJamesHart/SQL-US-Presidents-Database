CREATE TABLE USPresidents (
	PresidentName			Varchar(25)		NOT NULL,
	FormerOccupation 		Text		    NULL,
	PresPoliticalParty 		Varchar(25)		NULL,
    PresHomeState			Varchar(50)		NOT NULL,
    HeightCM	 	  		Int	    	    NOT NULL,	
	PRIMARY KEY(PresidentName)
	)ENGINE=INNODB;
CREATE INDEX PresidentNameIndex on USPresidents(PresidentName);
CREATE INDEX PresPoliticalPartyIndex on USPresidents(PresPoliticalParty);
CREATE INDEX PresHomeStateIndex on USPresidents(PresHomeState);
CREATE INDEX HeightCMIndex on USPresidents(HeightCM);

CREATE TABLE Presidencies (
	PresidentNumber 		 Int 				NOT NULL,
	PresidentName 			 Varchar(25)		NOT NULL,
    PresTermStart			 Int    			NOT NULL,
	PresTermEnd 			 Int    			NULL,
	PRIMARY KEY(PresidentNumber),
    FOREIGN KEY(PresidentName) REFERENCES USPresidents(PresidentName)
 							        ON UPDATE CASCADE
									ON DELETE CASCADE
	)ENGINE=INNODB;
CREATE INDEX PresidentNumberIndex on Presidencies(PresidentNumber);
CREATE INDEX PresTermStartIndex on Presidencies(PresTermStart);
CREATE INDEX PresTermEnd on Presidencies(PresTermEnd);

CREATE TABLE VicePresidents (
	VPName					Varchar(25)		NOT NULL,
	VPPoliticalParty 		Varchar(25)		NULL,
    VPHomeState				Varchar(50)		NOT NULL,
	PRIMARY KEY(VPName)
	)ENGINE=INNODB;
CREATE INDEX VPNameIndex on VicePresidents(VPName);
CREATE INDEX VPPoliticalPartyIndex on VicePresidents(VPPoliticalParty);
CREATE INDEX VPHomeStateIndex on VicePresidents(VPHomeState);

CREATE TABLE Universities (
	UniversityName		    Varchar(200) 	NOT NULL,
    State					Varchar(50)		NOT NULL,
	Ranking 				Int 			NOT NULL,
	PRIMARY KEY(UniversityName)				
	)ENGINE=INNODB;
CREATE INDEX UniversityNameIndex on Universities(UniversityName);
CREATE INDEX RankingIndex on Universities(Ranking);

CREATE TABLE PresidentAttendance (
	PresAttendanceID 			 Int 				NOT NULL,
	UniversityName		   		Varchar(200) 		NOT NULL,
	PresidentName		        Varchar(25)		    NOT NULL,
	PresWithdrawYesNo      	    Varchar(3)			NOT NULL	CHECK (PresWithdrawYesNo="Yes" OR PresWithdrawYesNo="No"),
    PresTransferOutYesNo	    Varchar(3)			NOT NULL	CHECK (PresTransferOutYesNo="Yes" OR PresTransferOutYesNo="No"),
	PRIMARY KEY(PresAttendanceID),
    FOREIGN KEY(UniversityName) REFERENCES Universities(UniversityName)
 							        ON UPDATE CASCADE
									ON DELETE CASCADE,
    FOREIGN KEY(PresidentName) REFERENCES USPresidents(PresidentName)
 							        ON UPDATE CASCADE
									ON DELETE CASCADE
	)ENGINE=INNODB;
CREATE INDEX PresAttendanceIDIndex on PresidentAttendance(PresAttendanceID);
CREATE INDEX PresWithdrawYesNoIndex on PresidentAttendance(PresWithdrawYesNo);
CREATE INDEX PresTransferOutYesNoIndex on PresidentAttendance(PresTransferOutYesNo);

CREATE TABLE VPAttendance (
	VPAttendanceID 			 Int 				NOT NULL,
	UniversityName		     Varchar(200) 		NOT NULL,
	VPName		     		 Varchar(25)		NOT NULL,
	VPWithdrawYesNo      	 Varchar(3)			NOT NULL	CHECK (VPWithdrawYesNo="Yes" OR VPWithdrawYesNo="No"),
	PRIMARY KEY(VPAttendanceID),
    FOREIGN KEY(UniversityName) REFERENCES Universities(UniversityName)
 							        ON UPDATE CASCADE
									ON DELETE CASCADE,
    FOREIGN KEY(VPName) REFERENCES VicePresidents(VPName)
 							        ON UPDATE CASCADE
									ON DELETE CASCADE
	)ENGINE=INNODB;
CREATE INDEX VPAttendanceIDIndex on VPAttendance(VPAttendanceID);
CREATE INDEX VPWithdrawYesNoIndex on VPAttendance(VPWithdrawYesNo);

CREATE TABLE VicePresidencies (
	VPNumber 			 Int 				NOT NULL,
	VPName 		 		 Varchar(25)		NOT NULL,
	PRIMARY KEY(VPNumber),
    FOREIGN KEY(VPName) REFERENCES VicePresidents(VPName)
 							        ON UPDATE CASCADE
									ON DELETE CASCADE
	)ENGINE=INNODB;
CREATE INDEX VPNumberIndex on VicePresidencies(VPNumber);

CREATE TABLE VicePresPairings (
	VicePresPairingID	 Int 				NOT NULL,
	PresidentName 		 Varchar(25)		NOT NULL,
	VPName 	   		 	 Varchar(25)		NOT NULL,
    PairingTermStart	 Int 			    NOT NULL,
	PairingTermEnd 	     Int 		    	NULL,
	PRIMARY KEY(VicePresPairingID),
	FOREIGN KEY(PresidentName) REFERENCES USPresidents(PresidentName)
 							        ON UPDATE CASCADE
									ON DELETE CASCADE,
	FOREIGN KEY(VPName) REFERENCES VicePresidents(VPName)
 							        ON UPDATE CASCADE
									ON DELETE CASCADE
	)ENGINE=INNODB;
CREATE INDEX VicePresPairingIDIndex on VicePresPairings(VicePresPairingID);
CREATE INDEX PairingTermStartIndex on VicePresPairings(PairingTermStart);
CREATE INDEX PairingTermEndIndex on VicePresPairings(PairingTermEnd);