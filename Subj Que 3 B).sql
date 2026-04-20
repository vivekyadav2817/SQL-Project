-- Subjective Question 3:What are some of the parameters that should be focused on while selecting the players?
-- For Batsmen: 2.	Average Runs Scored (Top 10 Players)

use ipl;
SELECT 
    p.Player_Name,
    ROUND(SUM(b.Runs_Scored) * 1.0 / COUNT(DISTINCT m.Match_Id), 2) AS Avg_Runs_Per_Match
FROM 
    Ball_by_Ball b
JOIN Matches m ON b.Match_Id = m.Match_Id
JOIN Player p ON b.Striker = p.Player_Id
GROUP BY 
    p.Player_Name
HAVING COUNT(DISTINCT m.Match_Id) >= 5
ORDER BY Avg_Runs_Per_Match DESC;



