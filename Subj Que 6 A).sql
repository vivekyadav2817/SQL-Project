-- Question 6.	What would you suggest to RCB before going to the mega auction? 
-- A. Retain existing RCB players with high match impact:
use ipl;
SELECT 
    p.Player_Name,
    COUNT(DISTINCT m.Match_Id) AS Matches_Played,
    SUM(CASE WHEN m.Match_Winner = b.Team_Batting THEN 1 ELSE 0 END) AS Matches_Won,
    ROUND(SUM(CASE WHEN m.Match_Winner = b.Team_Batting THEN 1 ELSE 0 END) * 100.0 / COUNT(DISTINCT m.Match_Id), 2) AS Win_Percentage
FROM Ball_by_Ball b
JOIN Matches m ON b.Match_Id = m.Match_Id
JOIN Player p ON b.Striker = p.Player_Id
WHERE b.Team_Batting = 2
GROUP BY p.Player_Name
HAVING Matches_Played >= 10
ORDER BY Win_Percentage DESC
LIMIT 10;
