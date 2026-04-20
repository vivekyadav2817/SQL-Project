-- Question 3: How many players were more than the age of 25 during season 2014?

use ipl;
SELECT 
  COUNT(DISTINCT p.Player_Id) AS Players_Above_25
FROM 
  Player p
JOIN 
  Player_Match pm ON p.Player_Id = pm.Player_Id
JOIN 
  Matches m ON pm.Match_Id = m.Match_Id
JOIN 
  Season s ON m.Season_Id = s.Season_Id
WHERE 
  s.Season_Year = 2014
  AND TIMESTAMPDIFF(YEAR, p.DOB, '2014-01-01') > 25;