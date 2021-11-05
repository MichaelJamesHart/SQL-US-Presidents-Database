-- View 1: Term Length --
CREATE VIEW PresidentTermLength AS
SELECT USPresidents.PresidentName,
PresidentNumber,
PresTermStart,
(PresTermEnd - PresTermStart) AS PresTermLength
FROM USPresidents
INNER JOIN Presidencies
ON USPresidents.PresidentName = Presidencies.PresidentName
ORDER BY PresTermStart;

-- View 2: President Height --
CREATE VIEW USPresidentHeights AS
SELECT USPresidents.PresidentName,
HeightCM AS PresidentHeightCM,
PresTermSTart AS PresidentTermStart
FROM USPresidents
INNER JOIN Presidencies
ON USPresidents.PresidentName = Presidencies.PresidentName
ORDER BY HeightCM;


-- View 3: University Rankings --
CREATE VIEW PresidentUniversityRankings AS
SELECT AVG(Ranking) AS PresidentRankingsAverage
FROM USPresidents
INNER JOIN PresidentAttendance
ON USPresidents.PresidentName = PresidentAttendance.PresidentName
INNER JOIN Universities
ON PresidentAttendance.UniversityName = Universities.UniversityName;

CREATE VIEW VicePresidentUniversityRankings AS
SELECT AVG(Ranking) AS VicePresidentRankingsAverage
FROM VicePresidents
INNER JOIN VPAttendance
ON VicePresidents.VPName = VPAttendance.VPName
INNER JOIN Universities
ON VPAttendance.UniversityName = Universities.UniversityName;


-- View 4: Vice Presidents Who Became President --
CREATE VIEW PresidentsWhoWereVicePresidents AS
SELECT * FROM USPresidents
WHERE USPresidents.PresidentName
IN (SELECT VicePresPairings.VPName FROM VicePresPairings);


-- View 5: Term Length By Party --
CREATE VIEW AverageTermLengthByParty AS
SELECT PresPoliticalParty AS PresidentsPoliticalParty,
AVG(PresTermEnd - PresTermStart) AS AverageTermLength
FROM USPresidents
INNER JOIN Presidencies
ON USPresidents.PresidentName = Presidencies.PresidentName
GROUP BY PresPoliticalParty
ORDER BY AverageTermLength;

-- View 6: College Dropouts --
CREATE VIEW CollegeDropOutPresidents AS
SELECT USPresidents.PresidentName,
PresidentAttendance.UniversityName AS DroppedOutOf,
Universities.State AS UniversityState,
Ranking AS UniversityRanking,
PresTermStart AS PresidentTermStart
FROM Universities
INNER JOIN PresidentAttendance
ON Universities.UniversityName = PresidentAttendance.UniversityName
INNER JOIN USPresidents
ON PresidentAttendance.PresidentName = USPresidents.PresidentName
INNER JOIN Presidencies
ON USPresidents.PresidentName = Presidencies.PresidentName
WHERE PresidentAttendance.PresWithdrawYesNo = "Yes"
ORDER BY PresTermStart;

-- View 7: Different Parties --
CREATE VIEW PresidentAndVicePresFromDiffParties AS
SELECT USPresidents.PresidentName,
VicePresidents.VPName
FROM USPresidents
INNER JOIN VicePresPairings
ON USPresidents.PresidentName = VicePresPairings.PresidentName
INNER JOIN VicePresidents
ON VicePresPairings.VPName = VicePresidents.VPName
WHERE PresPoliticalParty != VPPoliticalParty;