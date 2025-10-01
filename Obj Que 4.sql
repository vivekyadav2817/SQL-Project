-- Question 4:	How many matches did RCB win in 2013? 

use ipl;
SELECT 
  COUNT(*) AS Matches_Won_By_RCB
FROM 
  Matches m
JOIN 
  Season s ON m.Season_Id = s.Season_Id
WHERE 
  s.Season_Year = 2013
  AND m.Match_Winner = (
    SELECT Team_Id 
    FROM Team 
    WHERE Team_Name = 'Royal Challengers Bangalore'
  );